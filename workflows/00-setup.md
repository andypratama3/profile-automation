# Setup Lingkungan

Panduan setup — work di macOS, Linux, dan Windows.

## Prasyarat

| Tools | Cara Install |
|-------|-------------|
| Python 3.12+ | `brew install python@3.12` (macOS), `apt install python3.12` (Linux), [python.org](https://python.org) (Windows) |
| uv | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| browser-act CLI | `uv tool install browser-act-cli --python 3.12` |
| Google Chrome | [google.com/chrome](https://google.com/chrome) |

## Langkah

### 1. Clone & Install

```bash
git clone https://github.com/andypratama3/profile-automation.git
cd profile-automation

# Cek browser-act
browser-act --version
```

### 2. Isi Data Pribadi

```bash
cp data/profile.template.json data/profile.json
nano data/profile.json  # atau editor favorit kamu
```

### 3. Start Chrome

```bash
# macOS
./scripts/start-chrome.sh

# Linux
google-chrome --remote-debugging-port=9222 &

# Windows
"C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222
```

### 4. Login ke Platform

Di Chrome yang baru kebuka:
1. **LinkedIn** → https://linkedin.com → login
2. **Magentaku** → https://magentaku.id → login (kalau perlu)
3. Biarkan tab tetap terbuka

### 5. Buat Session

```bash
browser-act --session main chrome-direct
browser-act --session main go https://linkedin.com
browser-act --session main state
```

Kalau muncul feed LinkedIn → siap! Kalau muncul login page → login dulu di Chrome.

### 6. Cek Semua Beres

```bash
# Cek Chrome nyala
curl http://localhost:9222/json/version

# Cek session hidup
browser-act --session main state

# Cek data profile
python3 -c "import json; d=json.load(open('data/profile.json')); print('Nama:', d['name'])"
```

## Udah Siap? Lanjut ke Life Hack 🔥

Baca `workflows/01-auto-apply.md` — biar AI yang cari dan lamarin kerja buat kamu.
