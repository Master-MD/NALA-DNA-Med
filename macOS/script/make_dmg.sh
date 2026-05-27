#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_NAME="NALA-DNA-Med"
DIST_DIR="$ROOT_DIR/dist"
DMG_ROOT="$DIST_DIR/dmgroot"
DMG_PATH="$DIST_DIR/$APP_NAME.dmg"

"$ROOT_DIR/script/build_and_run.sh" release-stage >/dev/null

rm -rf "$DMG_ROOT" "$DMG_PATH"
mkdir -p "$DMG_ROOT"
cp -R "$DIST_DIR/$APP_NAME.app" "$DMG_ROOT/"
ln -s /Applications "$DMG_ROOT/Applications"
cp "$ROOT_DIR/README.md" "$DMG_ROOT/README.md"
cp -R "$ROOT_DIR/docs" "$DMG_ROOT/docs"
cp "$ROOT_DIR/docs/install/CAVEMAN_INSTALL.md" "$DMG_ROOT/CAVEMAN_INSTALL.md"
cp "$ROOT_DIR/docs/generation/FAQ.md" "$DMG_ROOT/FAQ.md"
find "$DMG_ROOT" -name ".DS_Store" -delete

hdiutil create \
  -volname "$APP_NAME" \
  -srcfolder "$DMG_ROOT" \
  -ov \
  -format UDZO \
  "$DMG_PATH"

echo "$DMG_PATH"
