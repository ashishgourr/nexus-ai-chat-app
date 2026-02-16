#!/usr/bin/env bash
# Run `pod install` for iOS using Homebrew Ruby when available (fixes ffi_c / wrong-architecture errors on Apple Silicon).
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
IOS_DIR="$PROJECT_DIR/ios"
if [[ ! -d "$IOS_DIR" ]]; then
  echo "Error: ios directory not found at $IOS_DIR"
  exit 1
fi
# Prefer Homebrew Ruby (arm64) so ffi gem loads correctly on Apple Silicon
if [[ -x "/opt/homebrew/opt/ruby/bin/ruby" ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  echo "Using Homebrew Ruby: $(which ruby)"
fi
echo "Running pod install in $IOS_DIR ..."
cd "$IOS_DIR"
pod install
echo "Done. If 'flutter run' on iOS still fails with ffi_c, add to ~/.zshrc: export PATH=\"/opt/homebrew/opt/ruby/bin:\$PATH\" then restart the terminal."
