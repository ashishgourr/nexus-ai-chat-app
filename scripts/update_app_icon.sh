#!/usr/bin/env bash
# Replace default Flutter launcher icon with Nexus AI icon (assets/icon/app_icon.png).
# Run from project root: ./scripts/update_app_icon.sh
# Or: dart run flutter_launcher_icons
set -e
cd "$(dirname "$0")/.."
dart run flutter_launcher_icons
echo "Done. Do a full rebuild: flutter clean && flutter pub get && flutter run"
