#!/usr/bin/env bash
# Load GEMINI_API_KEY from .env and run Flutter with --dart-define.
# Usage: ./run_with_env.sh [flutter args...]
#        ./run_with_env.sh build apk
#        ./run_with_env.sh build ios --release

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GEMINI_API_KEY=""
if [ -f .env ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      GEMINI_API_KEY=*) GEMINI_API_KEY="${line#GEMINI_API_KEY=}"; break ;;
    esac
  done < .env
fi

DART_DEFINE=""
if [ -n "$GEMINI_API_KEY" ]; then
  DART_DEFINE="--dart-define=GEMINI_API_KEY=$GEMINI_API_KEY"
fi

if [ "$1" = "build" ]; then
  flutter build "${@:2}" $DART_DEFINE
else
  flutter run $DART_DEFINE "$@"
fi
