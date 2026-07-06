---
name: profile-automation
description: "Asisten pencari kerja otomatis — baca CV, cari lowongan, lamar otomatis via LinkedIn & job portal, update profil Magentaku, generate CV ATS."
---

# Profile Automation — Si Pemburu Kerja Otomatis

Gunakan skill ini ketika user minta:
1. Mencari dan melamar kerja otomatis (Life Hack Auto-Apply)
2. Update profil Magentaku ID (data pribadi, pengalaman, pendidikan, dll)
3. Generate CV ATS dari data profile
4. Setup browser-act + chrome-direct untuk automation

## Cara Kerja

User login sekali ke LinkedIn/Magentaku di Chrome. Automation numpang pake session itu via Chrome DevTools Protocol. **Tidak ada password yang disimpan.**

## Setup Awal

```bash
# 1. Start Chrome
pkill -f "Google Chrome" 2>/dev/null; sleep 1
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222 &

# 2. Login di Chrome:
#    - https://linkedin.com
#    - https://magentaku.id

# 3. Buat session
browser-act --session main chrome-direct
browser-act --session main go https://linkedin.com
browser-act --session main state  # verifikasi sudah login

# 4. Baca data profile
#    data/profile.json — nama, stack, role, kontak, dll.
```

## 🧠 Life Hack: Auto-Apply (Workflow Utama)

**Ini fitur andalan.** Sistem akan:

1. **Baca CV kamu** dari `data/profile.json` → tahu role, stack, pengalaman
2. **Buat kata kunci** dari stack kamu (Laravel, React, Next.js, dll)
3. **Cari lowongan** di LinkedIn yang cocok
4. **Deteksi tipe** — Easy Apply atau External Apply
5. **Lamar otomatis** — isi form, upload CV, jawab screening
6. **Catat hasil** ke `LAMARAN.md`

### Step-by-step Auto-Apply:

```bash
# 1. Cari lowongan berdasarkan stack dari CV
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer+Laravel+React&location=Jakarta&f_AL=true"
browser-act --session main wait stable

# 2. Klik job card pertama
browser-act --session main state  # cari element job card, klik

# 3. Cek tombol lamaran
#    "Melamar Mudah" → Easy Apply
#    "Lamar di website perusahaan" → External Apply

# 4a. Easy Apply:
#    - Klik "Melamar Mudah"
#    - Isi HP dari profile.json
#    - Jawab screening questions
#    - Klik "Lanjutkan" → "Kirim lamaran"
#    - Catat: ✅ Terkirim

# 4b. External Apply:
#    - Klik link, ke tab baru
#    - Upload CV, isi Nama/Email/HP dari profile.json
#    - Submit
#    - Catat: ✅ atau ⏳

# 5. Balik ke hasil pencarian, klik job berikutnya
#    Ulangi langkah 2-5
```

### Filter Pencarian Efektif

```
Easy Apply only:     &f_AL=true
Remote:              &f_WT=2
Hybrid:              &f_WT=3
24 jam terakhir:     &f_TPR=r86400
1 minggu terakhir:   &f_TPR=r604800
Gaji tercantum:      &f_SB=2
```

## Workflow 2: Update Profil Magentaku

### Data Pribadi
```bash
browser-act --session main go https://magentaku.id/profil/data-pribadi
```
Isi `about`, nama, NIK, no HP, email, alamat, sosmed dari `data/profile.json`.

### Pengalaman (Work Experience)
```bash
browser-act --session main go https://magentaku.id/profil/data-akademik/edit
```
Untuk tiap pengalaman: klik Tambah → isi jabatan/perusahaan/type/tanggal/deskripsi → submit.

**Jenis value**: `project_base`, `magang`, `pekerja_lepas`, `part_time`, `full_time`

### Sertifikasi
```javascript
document.getElementById("name").value = "Nama Sertifikasi";
document.getElementById("publisher").value = "Penerbit";
document.getElementById("published_at")._flatpickr.setDate("2024-01-01");
document.getElementById("submitCertification").click();
```

### Pendidikan
Pilih jenjang (`5`=D4, `1`=S1), cari universitas via Select2, isi program studi, status, IPK, submit.

### Keahlian
Gunakan Select2 multiselect untuk milih hard skills & soft skills. Klik "Simpan Perubahan".

## Workflow 3: Generate CV ATS

```bash
python scripts/generate_cv.py --data data/profile.json --output cv_saya.docx
```

## Workflow 4: Update Dokumen Magentaku

```bash
browser-act --session main go https://magentaku.id/profil/cv
# Scroll ke "Kelengkapan Dokumen"
# Upload KTP, CV, Sertifikat, Transkrip, dll.
```

## Pola Penting

### Select2
```javascript
window.jQuery("[name=type]").val("value").trigger("change");
$("select").data("select2").dropdown.$search.val("cari").trigger("keyup");
```

### flatpickr (tanggal)
```javascript
document.getElementById("id")._flatpickr.setDate("2024-11-01");
// JANGAN set value langsung — pasti error
```

### Upload File
```javascript
var input = document.querySelector("input[type=file]");
var dt = new DataTransfer();
dt.items.add(new File([""], "file.pdf", {type: "application/pdf"}));
input.files = dt.files;
input.dispatchEvent(new Event("change", {bubbles: true}));
```

### Modal Handling
```javascript
document.querySelector(".swal2-confirm").click();  // SweetAlert
document.querySelector(".btn-close").click();       // Bootstrap
```

### Trigger Form Detection
```javascript
el.value = "xxx";
el.dispatchEvent(new Event("input", {bubbles: true}));
el.dispatchEvent(new Event("change", {bubbles: true}));
```

## Session Management

```bash
# Buat session baru
browser-act --session main chrome-direct

# Chrome mati? Restart:
pkill -f "Google Chrome"
sleep 1
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222 &
browser-act --session main chrome-direct

# Multiple session (beda platform)
browser-act --session linkedin chrome-direct
browser-act --session magentaku chrome-direct
```

## Troubleshooting

| Masalah | Solusi |
|---------|--------|
| Chrome ga konek | Start pake `--remote-debugging-port=9222` |
| Session hangus | `browser-act --session main chrome-direct` |
| "Jenis organisasi wajib diisi" | Pake jQuery `.trigger("change")` |
| "Tanggal tidak valid" | Pake `_flatpickr.setDate()`, value langsung = error |
| LinkedIn minta login | Login manual di Chrome window |
| Skill ga nambah | Pake jQuery `.trigger("change")` |

## Data Reference

Semua data di `data/profile.json`:

```json
{
  "name": "Nama",
  "email": "email@example.com",
  "phone": "62812xxxx",
  "role": "Senior Fullstack Developer",
  "stack": ["Laravel", "React", "Next.js", "PHP 8"],
  "headline": "Senior Fullstack | Laravel, React, Next.js",
  "resume_path": "/path/to/cv.pdf",
  "linkedin_url": "https://linkedin.com/in/..."
}
```
