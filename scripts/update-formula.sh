#!/usr/bin/env bash
#
# update-formula.sh — Update a Homebrew formula with new version, URLs, and sha256 checksums.
#
# Usage: ./scripts/update-formula.sh <tool> <version> <repo>
#   tool    — formula name (e.g., limbo, nyx, qorvex, wisp-cli)
#   version — version WITHOUT v prefix (e.g., 0.2.0)
#   repo    — GitHub owner/repo (e.g., simonspoon/limbo)
#
# Requires: gh CLI (authenticated)
# Compatible with bash 3.x (macOS default)

set -euo pipefail

TOOL="${1:?Usage: update-formula.sh <tool> <version> <repo>}"
VERSION="${2:?Usage: update-formula.sh <tool> <version> <repo>}"
REPO="${3:?Usage: update-formula.sh <tool> <version> <repo>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FORMULA_DIR="$(cd "$SCRIPT_DIR/../Formula" && pwd)"
FORMULA_FILE="$FORMULA_DIR/${TOOL}.rb"

if [[ ! -f "$FORMULA_FILE" ]]; then
  echo "Error: Formula file not found: $FORMULA_FILE" >&2
  exit 1
fi

TAG="v${VERSION}"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading release assets for ${REPO}@${TAG}..."
gh release download "$TAG" --repo "$REPO" --dir "$TMPDIR" --pattern '*.tar.gz' --pattern '*-darwin-*' --pattern '*-linux-*' --pattern '*-macos-*' --pattern '*.zip' 2>/dev/null || true

# Build checksum file: each line is "filename sha256"
CHECKSUM_FILE="$TMPDIR/.checksums"
asset_count=0
for file in "$TMPDIR"/*; do
  [[ -f "$file" ]] || continue
  fname="$(basename "$file")"
  sha="$(shasum -a 256 "$file" | awk '{print $1}')"
  echo "$fname $sha" >> "$CHECKSUM_FILE"
  echo "  $fname: $sha"
  asset_count=$((asset_count + 1))
done

if [[ "$asset_count" -eq 0 ]]; then
  echo "Error: No assets downloaded for ${REPO}@${TAG}" >&2
  exit 1
fi

# Lookup function: get sha256 for an asset name
get_checksum() {
  local name="$1"
  grep "^${name} " "$CHECKSUM_FILE" | awk '{print $2}'
}

# Update version line
sed -i '' "s|^  version \".*\"|  version \"${VERSION}\"|" "$FORMULA_FILE"

# Update all url lines: replace the version in the URL path
OLD_TAG_PATTERN='releases/download/v[0-9][0-9.]*/'
NEW_TAG_PREFIX="releases/download/${TAG}/"
sed -i '' "s|${OLD_TAG_PATTERN}|${NEW_TAG_PREFIX}|g" "$FORMULA_FILE"

# A formula renamed upstream (mesa -> naru) still names the old assets on its
# url lines. When a url's asset was not downloaded but "<tool>-<same suffix>"
# was, point the url at that asset. A formula whose assets were all downloaded
# is left untouched.
for asset in $(sed -n 's|^[[:space:]]*url "\(.*\)".*|\1|p' "$FORMULA_FILE" | sed 's|.*/||' | sort -u); do
  [[ -z "$(get_checksum "$asset")" ]] || continue
  renamed="${TOOL}-${asset#*-}"
  if [[ "$renamed" != "$asset" && -n "$(get_checksum "$renamed")" ]]; then
    echo "  Renaming asset ${asset} -> ${renamed}"
    sed -i '' "s|/${asset}\"|/${renamed}\"|" "$FORMULA_FILE"
  fi
done

# Update sha256 values by matching the url on the preceding line
TEMP_FORMULA="$(mktemp)"
prev_url=""
while IFS= read -r line; do
  # Capture url lines to know which asset we're looking at
  if [[ "$line" =~ url\ \"(.+)\" ]]; then
    prev_url="${BASH_REMATCH[1]}"
    echo "$line" >> "$TEMP_FORMULA"
    continue
  fi

  # Update sha256 lines based on the preceding url
  if [[ "$line" =~ ^([[:space:]]*)sha256\ \" && -n "$prev_url" ]]; then
    asset_name="$(basename "$prev_url")"
    indent="${BASH_REMATCH[1]}"
    new_sha="$(get_checksum "$asset_name")"
    if [[ -n "$new_sha" ]]; then
      echo "${indent}sha256 \"${new_sha}\"" >> "$TEMP_FORMULA"
    else
      echo "Warning: No checksum found for asset: $asset_name" >&2
      echo "$line" >> "$TEMP_FORMULA"
    fi
    prev_url=""
    continue
  fi

  echo "$line" >> "$TEMP_FORMULA"
done < "$FORMULA_FILE"

mv "$TEMP_FORMULA" "$FORMULA_FILE"


# Regenerate the bin.install lines in `def install` from the release tarball.
# The binary list is otherwise hand-maintained and drifts silently when a
# binary is dropped or added upstream. Only formulas that ship a tarball and
# list their binaries literally are regenerated; bare-binary formulas (whose
# install block is a `Dir[...].first` expression) are left alone.

# Top-level binaries of a tarball, one per line, sorted. Returns non-zero when
# tar cannot list the archive at all, so the caller can refuse to guess.
# A top-level directory is listed with a trailing "/" plus its children, so
# every entry containing "/" is dropped. Files that tar reports as
# non-executable are dropped too, but only when the permission column parses —
# an unparseable column leaves the candidate list alone rather than emptying it.
tarball_binaries() {
  local tb="$1" listing names nonexec
  if ! listing="$(tar tzvf "$tb" 2>/dev/null)"; then
    echo "Warning: cannot list $(basename "$tb"): tar failed." >&2
    return 1
  fi
  names="$(tar tzf "$tb" | sed 's|^\./||' | grep -v '/' | grep -v '^$' | sort -u)" || true
  nonexec="$(printf '%s\n' "$listing" \
    | awk 'substr($1, 1, 1) == "-" && substr($1, 4, 1) != "x" {print $NF}' \
    | sed 's|^\./||' | grep -v '/' | grep -v '^$' | sort -u)" || true
  comm -23 <(printf '%s\n' "$names" | grep -v '^$') \
           <(printf '%s\n' "$nonexec" | grep -v '^$')
}

# Is "$1" one of the newline-separated names in "$2"?
list_contains() {
  printf '%s\n' "$2" | grep -qxF -- "$1"
}

# Rewrite the bin.install lines of "$1" from the binary list "$2", keeping the
# order of binaries that are still shipped and preserving every other line of
# the install block verbatim.
rewrite_install_block() {
  local formula="$1" bins="$2"
  local lines line i n=0
  local start=-1 blockend=-1 indent="" bin_indent=""

  while IFS= read -r line; do
    lines[$n]="$line"
    n=$((n + 1))
  done < "$formula"

  for ((i = 0; i < n; i++)); do
    if [[ "${lines[$i]}" =~ ^([[:space:]]*)def\ install[[:space:]]*$ ]]; then
      start=$i
      indent="${BASH_REMATCH[1]}"
      break
    fi
  done
  if [[ "$start" -lt 0 ]]; then
    echo "Warning: no 'def install' block found in $formula" >&2
    return 0
  fi

  for ((i = start + 1; i < n; i++)); do
    if [[ "${lines[$i]}" == "${indent}end" ]]; then
      blockend=$i
      break
    fi
  done
  if [[ "$blockend" -lt 0 ]]; then
    echo "Warning: unterminated 'def install' block in $formula" >&2
    return 0
  fi

  # Existing literal bin.install entries, in formula order.
  local existing=""
  for ((i = start + 1; i < blockend; i++)); do
    if [[ "${lines[$i]}" =~ ^([[:space:]]*)bin\.install\ \"([^\"]+)\"[[:space:]]*$ ]]; then
      if [[ -z "$bin_indent" ]]; then
        bin_indent="${BASH_REMATCH[1]}"
      fi
      existing="${existing}${BASH_REMATCH[2]}
"
    fi
  done
  if [[ -z "$existing" ]]; then
    echo "  def install lists no literal bin.install entries; left unchanged."
    return 0
  fi

  # Keep what is still shipped, append what is new.
  local name kept="" added=""
  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    if list_contains "$name" "$bins"; then
      kept="${kept}${name}
"
    else
      echo "  Removing bin.install \"${name}\" (not in tarball)"
    fi
  done <<< "$existing"

  while IFS= read -r name; do
    [[ -n "$name" ]] || continue
    if ! list_contains "$name" "$existing"; then
      added="${added}${name}
"
      echo "  Adding bin.install \"${name}\""
    fi
  done <<< "$bins"

  # New entries land after the last surviving bin.install line, or in the place
  # of the first one if none survived.
  local anchor=-1 first_bin=-1
  for ((i = start + 1; i < blockend; i++)); do
    if [[ "${lines[$i]}" =~ ^([[:space:]]*)bin\.install\ \"([^\"]+)\"[[:space:]]*$ ]]; then
      if [[ "$first_bin" -lt 0 ]]; then
        first_bin=$i
      fi
      if list_contains "${BASH_REMATCH[2]}" "$kept"; then
        anchor=$i
      fi
    fi
  done
  if [[ "$anchor" -lt 0 ]]; then
    anchor=$first_bin
  fi

  local out
  out="$(mktemp)"
  for ((i = 0; i < n; i++)); do
    if [[ "$i" -gt "$start" && "$i" -lt "$blockend" ]] &&
       [[ "${lines[$i]}" =~ ^([[:space:]]*)bin\.install\ \"([^\"]+)\"[[:space:]]*$ ]]; then
      if list_contains "${BASH_REMATCH[2]}" "$kept"; then
        printf '%s\n' "${lines[$i]}" >> "$out"
      fi
      if [[ "$i" -eq "$anchor" ]]; then
        while IFS= read -r name; do
          [[ -n "$name" ]] || continue
          printf '%s%s\n' "$bin_indent" "bin.install \"${name}\"" >> "$out"
        done <<< "$added"
      fi
      continue
    fi
    printf '%s\n' "${lines[$i]}" >> "$out"
  done
  mv "$out" "$formula"
}

# Collect the downloaded tarballs, if any.
TARBALLS=""
for file in "$TMPDIR"/*.tar.gz; do
  [[ -f "$file" ]] || continue
  TARBALLS="${TARBALLS}${file}
"
done

# A release can carry archives the formula never installs from — qorvex ships
# qorvex-android.tar.gz, a payload with no top-level binaries, alongside the two
# macos archives. Only the assets named by a url line describe the binaries, so
# everything else is ignored. Urls interpolate `v#{version}`, so the basename is
# taken from the literal text rather than a resolved url.
URL_ASSETS="$(sed -n 's|^[[:space:]]*url "\(.*\)".*|\1|p' "$FORMULA_FILE" | sed 's|.*/||' | sort -u)" || true
REFERENCED=""
while IFS= read -r tarball; do
  [[ -n "$tarball" ]] || continue
  if list_contains "$(basename "$tarball")" "$URL_ASSETS"; then
    REFERENCED="${REFERENCED}${tarball}
"
  fi
done <<< "$TARBALLS"

if [[ -z "$TARBALLS" ]]; then
  echo "No tarball asset downloaded; leaving 'def install' unchanged."
elif [[ -z "$REFERENCED" ]]; then
  echo "No downloaded tarball is referenced by a url line; leaving 'def install' unchanged."
else
  FIRST_TARBALL="$(printf '%s\n' "$REFERENCED" | grep -v '^$' | head -1)"

  if ! BINARIES="$(tarball_binaries "$FIRST_TARBALL")"; then
    echo "Warning: leaving 'def install' unchanged." >&2
    REFERENCED=""
  fi
fi

if [[ -n "$REFERENCED" ]]; then
  # The formula ships one tarball per architecture; they should agree.
  while IFS= read -r tarball; do
    [[ -n "$tarball" ]] || continue
    [[ "$tarball" != "$FIRST_TARBALL" ]] || continue
    other="$(tarball_binaries "$tarball")" || continue
    if [[ "$other" != "$BINARIES" ]]; then
      echo "Warning: $(basename "$tarball") ships a different binary set than $(basename "$FIRST_TARBALL"):" >&2
      comm -23 <(printf '%s\n' "$BINARIES") <(printf '%s\n' "$other") |
        sed "s|^|  only in $(basename "$FIRST_TARBALL"): |" >&2
      comm -13 <(printf '%s\n' "$BINARIES") <(printf '%s\n' "$other") |
        sed "s|^|  only in $(basename "$tarball"): |" >&2
    fi
  done <<< "$REFERENCED"

  if [[ -z "$BINARIES" ]]; then
    echo "Warning: no binaries found in $(basename "$FIRST_TARBALL"); leaving 'def install' unchanged." >&2
  else
    rewrite_install_block "$FORMULA_FILE" "$BINARIES"
  fi
fi

echo "Updated $FORMULA_FILE to version $VERSION"
