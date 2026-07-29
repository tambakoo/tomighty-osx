#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$ROOT_DIR/src"
TARGET_DIR="$SCRIPT_DIR/target"
BUILD_DIR="$SCRIPT_DIR/XcodeBuild"

mkdir -p "$TARGET_DIR" "$BUILD_DIR"

xcodebuild \
  -project "$SRC_DIR/Tomighty.xcodeproj" \
  -scheme Tomighty \
  -configuration Release \
  -derivedDataPath "$BUILD_DIR/DerivedData" \
  -destination "generic/platform=macOS" \
  ARCHS="arm64 x86_64" \
  ONLY_ACTIVE_ARCH=NO \
  CODE_SIGNING_ALLOWED=NO \
  build

rm -rf "$TARGET_DIR/Tomighty.app"
cp -R "$BUILD_DIR/DerivedData/Build/Products/Release/Tomighty.app" "$TARGET_DIR/Tomighty.app"
