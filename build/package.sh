#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/target"
APP_PATH="$TARGET_DIR/Tomighty.app"
PACKAGE_DIR="$TARGET_DIR/package"

if [ ! -d "$APP_PATH" ]; then
  "$SCRIPT_DIR/build.sh"
fi

VERSION="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP_PATH/Contents/Info.plist")"
DMG_PATH="$TARGET_DIR/Tomighty-$VERSION.dmg"

rm -rf "$PACKAGE_DIR" "$DMG_PATH"
mkdir -p "$PACKAGE_DIR"
cp -R "$APP_PATH" "$PACKAGE_DIR/Tomighty.app"
ln -s /Applications "$PACKAGE_DIR/Applications"

hdiutil create \
  -volname "Tomighty-$VERSION" \
  -srcfolder "$PACKAGE_DIR" \
  -format UDZO \
  -ov \
  "$DMG_PATH"

echo "$DMG_PATH"
