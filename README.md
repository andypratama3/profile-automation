# Profile Automation — Si Pemburu Kerja Otomatis

> **Clone, isi data kamu, dan biarkan AI melamar pekerjaan untukmu.**

---

## ✨ Life Hack: Cara Kerjanya

Tools ini adalah **asisten pencari kerja otomatis** yang:

1. **Membaca CV kamu** — dari file `data/profile.json` (nama, stack, pengalaman, skill)
2. **Menentukan role kamu** — misal: "Senior Fullstack Developer (Laravel + Next.js)"
3. **Mencari lowongan yang cocok** — di LinkedIn, job portal, dll.
4. **Melamar otomatis** — isi form, upload CV, jawab screening questions
5. **Lacak semua lamaran** — status, tanggal, perusahaan, link

**Tanpa simpan password.** Kamu login sekali di Chrome, botnya numpang pakai session itu.

---

## Yang Bisa Kamu Otomatiskan

| Fitur | Cara Kerja |
|-------|-----------|
| **🔍 Cari Lowongan Otomatis** | Scan LinkedIn & job portal berdasarkan role & stack kamu |
| **📝 Easy Apply** | Isi form lamaran LinkedIn otomatis (termasuk screening questions) |
| **🌐 External Apply** | Lamar di website perusahaan (Workday, Teamtailor, Dealls, dll) |
| **📄 Update Profil Magentaku** | Isi data pribadi, pengalaman, pendidikan, sertifikat, skill |
| **📑 Generate CV ATS** | Buat CV Word/PDF dari data kamu, siap upload |
| **📊 Tracking Lamaran** | Semua hasil lamaran tercatat otomatis |

---

## 📦 Isi Folder

```
profile-automation/
├── SKILL.md                       # Skill untuk Opencode AI
├── README.md                      # Ini — panduan lengkap
├── data/
│   ├── profile.template.json      # EDIT INI — data pribadi kamu
│   └── profile.json               # (otomatis dari template, di-gitignore)
├── workflows/
│   ├── 00-setup.md                # Setup lingkungan
│   ├── 01-auto-apply.md           # ★ LIFE HACK — cari & lamar kerja otomatis
│   ├── 02-linkedin-jobs.md        # Manual LinkedIn job application
│   ├── 03-magentaku-profile.md    # Update profil Magentaku
│   ├── 04-cv-generation.md        # Generate CV ATS
│   └── 05-common-patterns.md      # Pola reusable (Select2, flatpickr, upload)
├── scripts/
│   ├── setup.sh                   # Setup satu klik
│   ├── start-chrome.sh            # Start Chrome + remote debugging
│   └── generate_cv.py             # Generator CV dari profile.json
└── .gitignore
```

---

## 🚀 Quick Start (3 Menit)

### 1. Install Prasyarat

```bash
# Install browser-act CLI
uv tool install browser-act-cli --python 3.12

# Cek
browser-act --version
```

### 2. Isi Data Kamu

```bash
cp data/profile.template.json data/profile.json
# EDIT data/profile.json — ganti dengan data asli kamu!
```

### 3. Start Chrome & Login

```bash
# macOS
./scripts/start-chrome.sh

# Atau manual:
# 1. Buka Chrome
# 2. Login ke LinkedIn (https://linkedin.com)
# 3. Login ke Magentaku (https://magentaku.id)
```

### 4. Buat Session

```bash
browser-act --session main chrome-direct
browser-act --session main state
# Harusnya muncul feed LinkedIn kamu, bukan halaman login
```

### 5. JALANKAN LIFE HACK 🔥

```bash
# Biarkan AI yang cari & lamar kerja sesuai role kamu
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer&location=Jakarta&f_AL=true"

# Atau langsung pakai workflow auto-apply:
# Baca workflows/01-auto-apply.md untuk panduan lengkap
```

---

## 🧠 Life Hack: Auto-Apply Workflow

Ini fitur utamanya. Sistem akan:

1. **Baca CV kamu** dari `data/profile.json` — lihat stack, pengalaman, role
2. **Tentukan kata kunci** — misal: "Laravel", "React", "Fullstack Developer", "Next.js"
3. **Cari lowongan** di LinkedIn dengan kata kunci tersebut
4. **Deteksi tipe lamaran** — Easy Apply atau External Apply
5. **Lamar otomatis** — isi semua field, upload CV, jawab pertanyaan
6. **Catat hasilnya** ke file `LAMARAN.md`

### Contoh: Data Kamu

Misal data kamu seperti ini:
```json
{
  "name": "Andy Pratama",
  "role": "Senior Fullstack Developer",
  "stack": ["Laravel", "Next.js", "React", "PHP 8", "TypeScript", "MySQL", "Docker"],
  "headline": "Senior Fullstack Developer | Laravel, Next.js, React, TypeScript, PHP 8, REST API, DevOps"
}
```

Maka AI akan:
- Cari lowongan: `fullstack developer Laravel React`
- Lamar dengan headline + CV kamu
- Isi semua form dengan data kamu

**Hasilnya: dalam 1 sesi, bisa melamar ke 10-20+ lowongan.**

---

## 🔧 Setup untuk Semua OS

### macOS
```bash
./scripts/setup.sh
```

### Linux
```bash
# Install Chrome dulu:
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update && sudo apt install google-chrome-stable

# Jalankan:
bash scripts/setup.sh
```

### Windows (Git Bash / WSL)
```bash
# Start Chrome manual:
# "C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222

# Lalu:
browser-act --session main chrome-direct
```

---

## 📊 Tracking Lamaran

Semua hasil lamaran tercatat di file `LAMARAN.md`:

```markdown
## PT Maju Jaya - Fullstack Developer
- **Tanggal**: 2026-07-06
- **Platform**: LinkedIn
- **Tipe**: Easy Apply
- **Status**: ✅ Terkirim
- **Catatan**: -

## PT Tech Startup - Laravel Developer
- **Tanggal**: 2026-07-06
- **Platform**: LinkedIn
- **Tipe**: External Apply (Workday)
- **Status**: ⏳ Partial — form multi-page
- **Catatan**: Butuh isi manual 3 halaman
```

---

## ⚠️ Troubleshooting

| Masalah | Solusi |
|---------|--------|
| "No browser available" | Chrome mati. Jalankan `./scripts/start-chrome.sh` |
| Session hangus | Chrome di-restart. Buat ulang session |
| "element not found" | Halaman berubah. Jalanin `state` dulu |
| Select2 gak mau | Pakai jQuery: `$("el").val("x").trigger("change")` |
| Tanggal error | Pakai `_flatpickr.setDate("YYYY-MM-DD")` |
| LinkedIn minta login | Buka linkedin.com di Chrome, login ulang |
| Form terlalu ribet | Catat sebagai "partial" dan lanjut |

---

## 📤 Cara Upload ke GitHub

```bash
cd profile-automation
git init
git add .
git commit -m "Initial commit: profile automation suite"
git remote add origin https://github.com/andypratama3/profile-automation.git
git push -u origin main
```

**Atau clone dulu:**
```bash
git clone https://github.com/andypratama3/profile-automation.git
cd profile-automation
# Ikuti Quick Start di atas
```

---

Dibuat dengan ❤️ menggunakan [browser-act](https://www.browseract.com) + [Opencode](https://opencode.ai)
