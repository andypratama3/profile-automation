#!/usr/bin/env bash
set -euo pipefail

# Start Chrome dengan remote debugging port 9222
OS="$(uname -s)"
echo "Starting Chrome on port 9222..."

pkill -f "Google Chrome" 2>/dev/null || true
sleep 1

case "$OS" in
  Darwin)
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
      --remote-debugging-port=9222 \
      --no-first-run \
      --no-default-browser-check &
    ;;
  Linux)
    google-chrome --remote-debugging-port=9222 --no-first-run &
    ;;
  MINGW*|MSYS*)
    "/c/Program Files/Google/Chrome/Application/chrome.exe" \
      --remote-debugging-port=9222 &
    ;;
esac

echo "✅ Chrome started on port 9222"
echo "   Login ke LinkedIn & Magentaku di Chrome ini"
echo ""
echo "   Lalu: browser-act --session main chrome-direct"
