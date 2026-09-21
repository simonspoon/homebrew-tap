#!/usr/bin/env bash
#
# test-update-formula.sh — Drive update-formula.sh end to end against copies of
# the real formulas, with a fake `gh` on PATH serving fixture assets.
#
# No network, no gh auth. Prints PASS/FAIL per case and exits non-zero if any
# case fails.
#
# Compatible with bash 3.x (macOS default)

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

FAILURES=0

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; FAILURES=$((FAILURES + 1)); }

check() {
  # check <name> <expected> <actual>
  if [[ "$2" == "$3" ]]; then
    pass "$1"
  else
    fail "$1"
    echo "  expected:"; printf '%s\n' "$2" | sed 's|^|    |'
    echo "  actual:"; printf '%s\n' "$3" | sed 's|^|    |'
  fi
}

# The fake gh: `gh release download ... --dir <d>` copies the fixtures named by
# $FAKE_GH_FIXTURES into <d>. Everything else is ignored.
mkdir -p "$WORK/bin"
cat > "$WORK/bin/gh" <<'GH_EOF'
#!/usr/bin/env bash
set -euo pipefail
dir=""
prev=""
for arg in "$@"; do
  if [[ "$prev" == "--dir" ]]; then dir="$arg"; fi
  prev="$arg"
done
[[ -n "$dir" ]] || exit 1
cp "$FAKE_GH_FIXTURES"/* "$dir"/
GH_EOF
chmod +x "$WORK/bin/gh"
export PATH="$WORK/bin:$PATH"

# Build a tarball from a scratch dir so the top-level entries are exact.
# make_tarball <out.tar.gz> <dot|plain> <exec files...> -- <dir names...>
make_tarball() {
  local out="$1" style="$2"; shift 2
  local src="$WORK/src.$$.$RANDOM"
  mkdir -p "$src"
  local in_dirs=0 item
  for item in "$@"; do
    if [[ "$item" == "--" ]]; then in_dirs=1; continue; fi
    if [[ "$in_dirs" -eq 1 ]]; then
      mkdir -p "$src/$item"
      echo "source" > "$src/$item/Main.swift"
    else
      printf '#!/bin/sh\n' > "$src/$item"
      chmod +x "$src/$item"
    fi
  done
  if [[ "$style" == "dot" ]]; then
    tar czf "$out" -C "$src" .
  else
    ( cd "$src" && tar czf "$out" ./* )
  fi
  rm -rf "$src"
}

# A fresh scripts+Formula layout, so the real script's ../Formula resolution
# points at copies and never at the repo's own files.
new_tree() {
  local tree="$WORK/tree.$1"
  rm -rf "$tree"
  mkdir -p "$tree"
  cp -R "$REPO_ROOT/scripts" "$tree/scripts"
  cp -R "$REPO_ROOT/Formula" "$tree/Formula"
  printf '%s\n' "$tree"
}

install_block() {
  awk '/^  def install$/, /^  end$/' "$1"
}

# ---------------------------------------------------------------------------
# Case A — removal: the tarball no longer ships qorvex-live or qorvex-streamer.
# ---------------------------------------------------------------------------
FIX_A="$WORK/fix-a"
mkdir -p "$FIX_A"
make_tarball "$FIX_A/qorvex-macos-arm64.tar.gz" dot \
  qorvex qorvex-server qorvex-repl -- agent agent-android
make_tarball "$FIX_A/qorvex-macos-x86_64.tar.gz" dot \
  qorvex qorvex-server qorvex-repl -- agent agent-android

TREE_A="$(new_tree a)"
export FAKE_GH_FIXTURES="$FIX_A"
A_OUT="$("$TREE_A/scripts/update-formula.sh" qorvex 0.3.0 simonspoon/qorvex 2>&1)"
A_RC=$?
if [[ "$A_RC" -ne 0 ]]; then
  fail "A: script exited $A_RC"
  printf '%s\n' "$A_OUT" | sed 's|^|    |'
fi

EXPECTED_A='  def install
    bin.install "qorvex"
    bin.install "qorvex-server"
    bin.install "qorvex-repl"

    (share/"qorvex/agent").install Dir["agent/*"]
    (share/"qorvex/agent-android").install Dir["agent-android/*"]
  end'
check "A: stale binaries dropped, survivors keep their order, share lines intact" \
  "$EXPECTED_A" "$(install_block "$TREE_A/Formula/qorvex.rb")"

# ---------------------------------------------------------------------------
# Case B — addition: the tarball ships a new qorvex-probe.
# ---------------------------------------------------------------------------
FIX_B="$WORK/fix-b"
mkdir -p "$FIX_B"
make_tarball "$FIX_B/qorvex-macos-arm64.tar.gz" plain \
  qorvex qorvex-server qorvex-repl qorvex-probe -- agent agent-android
make_tarball "$FIX_B/qorvex-macos-x86_64.tar.gz" plain \
  qorvex qorvex-server qorvex-repl qorvex-probe -- agent agent-android

TREE_B="$(new_tree b)"
export FAKE_GH_FIXTURES="$FIX_B"
"$TREE_B/scripts/update-formula.sh" qorvex 0.3.0 simonspoon/qorvex > "$WORK/b.log" 2>&1 ||
  { fail "B: script exited non-zero"; sed 's|^|    |' "$WORK/b.log"; }

EXPECTED_B='  def install
    bin.install "qorvex"
    bin.install "qorvex-server"
    bin.install "qorvex-repl"
    bin.install "qorvex-probe"

    (share/"qorvex/agent").install Dir["agent/*"]
    (share/"qorvex/agent-android").install Dir["agent-android/*"]
  end'
check "B: new binary appended after the existing ones, nothing else changed" \
  "$EXPECTED_B" "$(install_block "$TREE_B/Formula/qorvex.rb")"

# ---------------------------------------------------------------------------
# Case C — directories are never installed.
# ---------------------------------------------------------------------------
# The general property: no bin.install argument may contain a "/". That covers
# the directories themselves ("agent/"), their children ("agent/Main.swift")
# and anything else nested that leaks out of the tarball listing.
C_HITS="$(grep -hE 'bin\.install "[^"]*/' \
  "$TREE_A/Formula/qorvex.rb" "$TREE_B/Formula/qorvex.rb" || true)"
C_HITS="${C_HITS}$(grep -hE 'bin\.install "(agent|agent-android)"' \
  "$TREE_A/Formula/qorvex.rb" "$TREE_B/Formula/qorvex.rb" || true)"
if [[ -z "$C_HITS" ]]; then
  pass "C: no bin.install argument contains a path separator"
else
  fail "C: a directory or nested path was turned into a bin.install line"
  printf '%s\n' "$C_HITS" | sed 's|^|    |'
fi

# ---------------------------------------------------------------------------
# Case D — bare-binary formula: no tarball, install block untouched.
# ---------------------------------------------------------------------------
FIX_D="$WORK/fix-d"
mkdir -p "$FIX_D"
for asset in mesa-darwin-arm64 mesa-darwin-amd64 mesa-linux-arm64 mesa-linux-amd64; do
  printf '#!/bin/sh\n' > "$FIX_D/$asset"
done

TREE_D="$(new_tree d)"
BEFORE_D="$(install_block "$TREE_D/Formula/mesa.rb")"
export FAKE_GH_FIXTURES="$FIX_D"
"$TREE_D/scripts/update-formula.sh" mesa 0.7.0 simonspoon/mesa > "$WORK/d.log" 2>&1 ||
  { fail "D: script exited non-zero"; sed 's|^|    |' "$WORK/d.log"; }
check "D: bare-binary formula's def install is byte-identical" \
  "$BEFORE_D" "$(install_block "$TREE_D/Formula/mesa.rb")"

# ---------------------------------------------------------------------------
# Case E — existing version/url/sha256 rewriting still works (case A's tree).
# ---------------------------------------------------------------------------
E_OK=1
E_MSG=""
if ! grep -q '^  version "0.3.0"$' "$TREE_A/Formula/qorvex.rb"; then
  E_OK=0; E_MSG="version line not updated"
fi
if ! grep -q 'releases/download/v#{version}/qorvex-macos-arm64.tar.gz' "$TREE_A/Formula/qorvex.rb"; then
  E_OK=0; E_MSG="${E_MSG}; url line changed unexpectedly"
fi
for arch in arm64 x86_64; do
  want="$(shasum -a 256 "$FIX_A/qorvex-macos-${arch}.tar.gz" | awk '{print $1}')"
  if ! grep -q "sha256 \"${want}\"" "$TREE_A/Formula/qorvex.rb"; then
    E_OK=0; E_MSG="${E_MSG}; sha256 for ${arch} not updated"
  fi
done
if [[ "$E_OK" -eq 1 ]]; then
  pass "E: version and sha256 lines still updated"
else
  fail "E:$E_MSG"
fi

# ---------------------------------------------------------------------------
# Case F — an unlistable tarball: refuse to guess, leave the block alone.
# ---------------------------------------------------------------------------
FIX_F="$WORK/fix-f"
mkdir -p "$FIX_F"
printf 'not a tarball' > "$FIX_F/qorvex-macos-arm64.tar.gz"
printf 'not a tarball' > "$FIX_F/qorvex-macos-x86_64.tar.gz"

TREE_F="$(new_tree f)"
BEFORE_F="$(install_block "$TREE_F/Formula/qorvex.rb")"
export FAKE_GH_FIXTURES="$FIX_F"
"$TREE_F/scripts/update-formula.sh" qorvex 0.3.0 simonspoon/qorvex > "$WORK/f.log" 2>&1
F_RC=$?
check "F: unlistable tarball leaves def install byte-identical" \
  "$BEFORE_F" "$(install_block "$TREE_F/Formula/qorvex.rb")"
if [[ "$F_RC" -eq 0 ]]; then
  pass "F: script still exits 0"
else
  fail "F: script exited $F_RC"
  sed 's|^|    |' "$WORK/f.log"
fi
if grep -q "cannot list qorvex-macos-arm64.tar.gz" "$WORK/f.log"; then
  pass "F: warning names the tarball it could not list"
else
  fail "F: no warning printed for the unlistable tarball"
  sed 's|^|    |' "$WORK/f.log"
fi

# ---------------------------------------------------------------------------
# Case G — the release carries an archive the formula never installs from.
# qorvex v0.3.2 ships qorvex-android.tar.gz, a payload archive with no
# top-level binaries, alongside the two macos archives the urls name.
# ---------------------------------------------------------------------------
FIX_G="$WORK/fix-g"
mkdir -p "$FIX_G"
make_tarball "$FIX_G/tool-macos-arm64.tar.gz" plain \
  tool tool-server tool-repl -- agent agent-android
make_tarball "$FIX_G/tool-macos-x86_64.tar.gz" plain \
  tool tool-server tool-repl -- agent agent-android
make_tarball "$FIX_G/tool-android.tar.gz" plain -- payload

TREE_G="$(new_tree g)"
cat > "$TREE_G/Formula/tool.rb" <<'RB'
class Tool < Formula
  desc "Fixture formula shaped like qorvex"
  homepage "https://github.com/simonspoon/tool"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/simonspoon/tool/releases/download/v#{version}/tool-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/simonspoon/tool/releases/download/v#{version}/tool-macos-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "tool"
    bin.install "tool-server"
    bin.install "tool-repl"
    bin.install "tool-live"
    bin.install "tool-streamer"

    (share/"tool/agent").install Dir["agent/*"]
  end
end
RB

export FAKE_GH_FIXTURES="$FIX_G"
"$TREE_G/scripts/update-formula.sh" tool 0.1.1 simonspoon/tool > "$WORK/g.log" 2>&1 ||
  { fail "G: script exited non-zero"; sed 's|^|    |' "$WORK/g.log"; }

EXPECTED_G='  def install
    bin.install "tool"
    bin.install "tool-server"
    bin.install "tool-repl"

    (share/"tool/agent").install Dir["agent/*"]
  end'
check "G: unreferenced payload archive does not block regeneration" \
  "$EXPECTED_G" "$(install_block "$TREE_G/Formula/tool.rb")"
if grep -q "no binaries found" "$WORK/g.log"; then
  fail "G: unreferenced archive tripped the empty-set guard"
  sed 's|^|    |' "$WORK/g.log"
else
  pass "G: no spurious 'no binaries found' warning"
fi

echo
if [[ "$FAILURES" -eq 0 ]]; then
  echo "All cases passed."
else
  echo "$FAILURES case(s) failed."
fi
exit "$FAILURES"
