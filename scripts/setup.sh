#!/usr/bin/env bash
set -euo pipefail

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   Profile Automation — Setup                 ║${NC}"
echo -e "${BOLD}║   Si Pemburu Kerja Otomatis 🚀               ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════╝${NC}"

# ── Step 1 ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}[1/5] Cek Prasyarat...${NC}"

command -v python3 >/dev/null 2>&1 || { echo -e "  ${RED}✗ Python 3 tidak ditemukan${NC}"; exit 1; }
echo -e "  ${GREEN}✓${NC} Python $(python3 --version 2>&1 | awk '{print $2}')"

command -v uv >/dev/null 2>&1 || { echo -e "  ${YELLOW}⚠ Install uv...${NC}"; curl -LsSf https://astral.sh/uv/install.sh | sh; }
echo -e "  ${GREEN}✓${NC} uv $(uv --version 2>&1 | awk '{print $2}')"

command -v browser-act >/dev/null 2>&1 || { echo -e "  ${YELLOW}⚠ Install browser-act...${NC}"; uv tool install browser-act-cli --python 3.12; }
echo -e "  ${GREEN}✓${NC} browser-act $(browser-act --version 2>&1 | head -1)"

# ── Step 2 ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}[2/5] Siapkan Data Profil...${NC}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_FILE="$SCRIPT_DIR/data/profile.json"

if [ ! -f "$DATA_FILE" ]; then
  if [ -f "$SCRIPT_DIR/data/profile.template.json" ]; then
    cp "$SCRIPT_DIR/data/profile.template.json" "$DATA_FILE"
    echo -e "  ${GREEN}✓${NC} File data/profile.json dibuat dari template"
    echo -e "  ${YELLOW}⚠ EDIT data/profile.json dengan data ASLI kamu!${NC}"
  fi
else
  echo -e "  ${GREEN}✓${NC} Data profil sudah ada"
fi

# ── Step 3 ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}[3/5] Start Chrome...${NC}"
pkill -f "Google Chrome" 2>/dev/null || true
sleep 1

OS="$(uname -s)"
case "$OS" in
  Darwin)
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
      --remote-debugging-port=9222 --no-first-run --no-default-browser-check &
    ;;
  Linux)
    google-chrome --remote-debugging-port=9222 --no-first-run --no-default-browser-check &
    ;;
  *)
    echo -e "  ${YELLOW}⚠ Start Chrome manual: chrome --remote-debugging-port=9222${NC}"
    ;;
esac

sleep 3
if curl -s http://localhost:9222/json/version >/dev/null 2>&1; then
  echo -e "  ${GREEN}✓${NC} Chrome siap di port 9222"
else
  echo -e "  ${RED}✗ Chrome belum siap. Start manual:${NC}"
  echo "    chrome --remote-debugging-port=9222"
fi

# ── Step 4 ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}[4/5] Buat browser-act session...${NC}"
browser-act --session main chrome-direct 2>/dev/null || {
  browser-act --session main chrome-direct
}
sleep 1
echo -e "  ${GREEN}✓${NC} Session 'main' siap"

# ── Step 5 ─────────────────────────────────────────────
echo ""
echo -e "${BOLD}[5/5] Verifikasi...${NC}"
browser-act --session main state >/dev/null 2>&1 && {
  echo -e "  ${GREEN}✓${NC} Session active"
} || {
  echo -e "  ${RED}✗ Session error. Cek Chrome & login dulu.${NC}"
}

# ── Done ───────────────────────────────────────────────
echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║  ✅ Setup Selesai!                            ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Langkah selanjutnya:"
echo -e "  1. ${YELLOW}Login ke LinkedIn${NC} di Chrome yang baru terbuka"
echo -e "  2. ${YELLOW}Login ke Magentaku${NC} (https://magentaku.id) kalau perlu"
echo -e "  3. ${YELLOW}Edit${NC} data/profile.json dengan data asli kamu"
echo -e "  4. Jalankan: ${BOLD}browser-act --session main go https://linkedin.com${NC}"
echo ""
echo -e "Biar makin gila: baca ${BOLD}workflows/01-auto-apply.md${NC}"
echo -e "Biarkan AI yang cari & lamar kerja buat kamu! 🔥"
