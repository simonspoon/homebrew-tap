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
gh release download "$TAG" --repo "$REPO" --dir "$TMPDIR" --pattern '*.tar.gz' --pattern '*-darwin-*' --pattern '*-linux-*' --pattern '*-macos-*' 2>/dev/null || true

# Build a map of asset filename -> sha256
declare -A CHECKSUMS
for file in "$TMPDIR"/*; do
  [[ -f "$file" ]] || continue
  basename="$(basename "$file")"
  sha="$(shasum -a 256 "$file" | awk '{print $1}')"
  CHECKSUMS["$basename"]="$sha"
  echo "  $basename: $sha"
done

if [[ ${#CHECKSUMS[@]} -eq 0 ]]; then
  echo "Error: No assets downloaded for ${REPO}@${TAG}" >&2
  exit 1
fi

# Update version line
sed -i '' "s|^  version \".*\"|  version \"${VERSION}\"|" "$FORMULA_FILE"

# Update all url lines: replace the version in the URL path
# URLs look like: .../releases/download/vX.Y.Z/asset-name
# We replace the tag portion and update the asset name's version if embedded
OLD_TAG_PATTERN='releases/download/v[0-9][0-9.]*/'
NEW_TAG_PREFIX="releases/download/${TAG}/"
sed -i '' "s|${OLD_TAG_PATTERN}|${NEW_TAG_PREFIX}|g" "$FORMULA_FILE"

# Now update sha256 values by matching the url on the preceding line
# Read the formula and process line by line
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
    if [[ -n "${CHECKSUMS[$asset_name]:-}" ]]; then
      echo "${indent}sha256 \"${CHECKSUMS[$asset_name]}\"" >> "$TEMP_FORMULA"
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

echo "Updated $FORMULA_FILE to version $VERSION"
