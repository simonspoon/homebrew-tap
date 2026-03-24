#!/usr/bin/env bash
#
# update-cask.sh — Update a Homebrew cask with new version and sha256 checksum.
#
# Usage: ./scripts/update-cask.sh <cask> <version> <repo>
#   cask    — cask name (e.g., wisp)
#   version — version WITHOUT v prefix (e.g., 0.3.0)
#   repo    — GitHub owner/repo (e.g., simonspoon/wisp)
#
# Requires: gh CLI (authenticated)
# Compatible with bash 3.x (macOS default)

set -euo pipefail

CASK="${1:?Usage: update-cask.sh <cask> <version> <repo>}"
VERSION="${2:?Usage: update-cask.sh <cask> <version> <repo>}"
REPO="${3:?Usage: update-cask.sh <cask> <version> <repo>}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CASK_DIR="$(cd "$SCRIPT_DIR/../Casks" && pwd)"
CASK_FILE="$CASK_DIR/${CASK}.rb"

if [[ ! -f "$CASK_FILE" ]]; then
  echo "Error: Cask file not found: $CASK_FILE" >&2
  exit 1
fi

TAG="v${VERSION}"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading .dmg for ${REPO}@${TAG}..."
gh release download "$TAG" --repo "$REPO" --dir "$TMPDIR" --pattern '*.dmg'

DMG_FILE="$(ls "$TMPDIR"/*.dmg 2>/dev/null | head -1)"
if [[ -z "$DMG_FILE" ]]; then
  echo "Error: No .dmg asset found for ${REPO}@${TAG}" >&2
  exit 1
fi

SHA="$(shasum -a 256 "$DMG_FILE" | awk '{print $1}')"
echo "  $(basename "$DMG_FILE"): $SHA"

# Update version
sed -i '' "s|^  version \".*\"|  version \"${VERSION}\"|" "$CASK_FILE"

# Update sha256
sed -i '' "s|^  sha256 \".*\"|  sha256 \"${SHA}\"|" "$CASK_FILE"

echo "Updated $CASK_FILE to version $VERSION"
