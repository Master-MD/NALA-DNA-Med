#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-run}"
APP_NAME="NALA-DNA-Med"
BUNDLE_ID="com.nala.dnamed"
MIN_SYSTEM_VERSION="14.0"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
APP_BUNDLE="$DIST_DIR/$APP_NAME.app"
APP_CONTENTS="$APP_BUNDLE/Contents"
APP_MACOS="$APP_CONTENTS/MacOS"
APP_RESOURCES="$APP_CONTENTS/Resources"
APP_BINARY="$APP_MACOS/$APP_NAME"
INFO_PLIST="$APP_CONTENTS/Info.plist"
ICNS_PATH="$ROOT_DIR/Resources/NALA-DNA-Med.icns"
RELEASE_ARCHS="${NALA_MACOS_ARCHS:-universal}"

release_triple_for_arch() {
  case "$1" in
    arm64)
      echo "arm64-apple-macosx$MIN_SYSTEM_VERSION"
      ;;
    x86_64)
      echo "x86_64-apple-macosx$MIN_SYSTEM_VERSION"
      ;;
    *)
      echo "Unsupported architecture: $1" >&2
      exit 2
      ;;
  esac
}

build_release_arch() {
  local arch="$1"
  local triple
  triple="$(release_triple_for_arch "$arch")"
  swift build -c release --triple "$triple" >&2
  echo "$(swift build -c release --triple "$triple" --show-bin-path)/$APP_NAME"
}

stage_binary() {
  local config="$1"

  if [[ "$config" == "release" ]]; then
    case "$RELEASE_ARCHS" in
      universal)
        local arm_binary x86_binary
        arm_binary="$(build_release_arch arm64)"
        x86_binary="$(build_release_arch x86_64)"
        lipo -create "$arm_binary" "$x86_binary" -output "$APP_BINARY"
        ;;
      arm64|x86_64)
        local single_binary
        single_binary="$(build_release_arch "$RELEASE_ARCHS")"
        cp "$single_binary" "$APP_BINARY"
        ;;
      native)
        swift build -c release
        cp "$(swift build -c release --show-bin-path)/$APP_NAME" "$APP_BINARY"
        ;;
      *)
        echo "Unsupported NALA_MACOS_ARCHS: $RELEASE_ARCHS" >&2
        echo "Use universal, arm64, x86_64, or native." >&2
        exit 2
        ;;
    esac
  else
    swift build
    cp "$(swift build --show-bin-path)/$APP_NAME" "$APP_BINARY"
  fi
}

stage_app() {
  local config="${1:-debug}"
  "$ROOT_DIR/script/make_icns.sh" >/dev/null
  pkill -x "$APP_NAME" >/dev/null 2>&1 || true

  rm -rf "$APP_BUNDLE"
  mkdir -p "$APP_MACOS" "$APP_RESOURCES"
  stage_binary "$config"
  cp "$ICNS_PATH" "$APP_RESOURCES/NALA-DNA-Med.icns"
  chmod +x "$APP_BINARY"

  cat >"$INFO_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key>
  <string>$APP_NAME</string>
  <key>CFBundleIdentifier</key>
  <string>$BUNDLE_ID</string>
  <key>CFBundleName</key>
  <string>$APP_NAME</string>
  <key>CFBundleDisplayName</key>
  <string>NALA-DNA-Med</string>
  <key>CFBundleIconFile</key>
  <string>NALA-DNA-Med</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>0.1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSMinimumSystemVersion</key>
  <string>$MIN_SYSTEM_VERSION</string>
  <key>NSHighResolutionCapable</key>
  <true/>
  <key>NSPrincipalClass</key>
  <string>NSApplication</string>
</dict>
</plist>
PLIST

  /usr/bin/codesign --force --deep --sign - "$APP_BUNDLE" >/dev/null
  lipo -info "$APP_BINARY"
}

open_app() {
  /usr/bin/open -n "$APP_BUNDLE"
}

case "$MODE" in
  run)
    stage_app debug
    open_app
    ;;
  --stage-only|stage)
    stage_app debug
    echo "$APP_BUNDLE"
    ;;
  --release-stage|release-stage)
    stage_app release
    echo "$APP_BUNDLE"
    ;;
  --debug|debug)
    stage_app debug
    lldb -- "$APP_BINARY"
    ;;
  --logs|logs)
    stage_app debug
    open_app
    /usr/bin/log stream --info --style compact --predicate "process == \"$APP_NAME\""
    ;;
  --telemetry|telemetry)
    stage_app debug
    open_app
    /usr/bin/log stream --info --style compact --predicate "subsystem == \"$BUNDLE_ID\""
    ;;
  --verify|verify)
    stage_app debug
    open_app
    sleep 2
    pgrep -x "$APP_NAME" >/dev/null
    echo "Verified running process: $APP_NAME"
    ;;
  *)
    echo "usage: $0 [run|stage|release-stage|--debug|--logs|--telemetry|--verify]" >&2
    exit 2
    ;;
esac
