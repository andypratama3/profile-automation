# 🧠 Life Hack: Auto-Apply — Cari & Lamar Kerja Otomatis

> **Biar AI yang bantuin kamu cari dan lamar kerja. Kamu tinggal duduk manis.**

---

## Alur Kerja

```
1. Baca CV/profile kamu → tentukan role + stack
2. Cari lowongan yang cocok di LinkedIn
3. Satu per satu: deteksi tipe → isi form → submit → catat
4. Ulangi sampai habis (atau sampai kamu capek)
```

---

## Step 1: Baca Data Kamu

AI akan membaca `data/profile.json` untuk tahu:

```json
{
  "name": "Nama Kamu",
  "email": "email@example.com",
  "phone": "62812xxxx",
  "role": "Senior Fullstack Developer",
  "stack": ["Laravel", "Next.js", "React", "PHP 8", "TypeScript", "MySQL", "PostgreSQL", "Docker", "REST API", "DevOps"],
  "headline": "Senior Fullstack Developer | Laravel, Next.js, React, TypeScript, PHP 8, REST API, DevOps, Docker, MySQL, PostgreSQL | A+ Security Grade",
  "resume_path": "/path/to/CV_ATS.pdf",
  "linkedin_url": "https://linkedin.com/in/namakamu"
}
```

**Tech stack yang terdeteksi**  → jadi kata kunci pencarian lowongan.

---

## Step 2: Cari Lowongan yang Cocok

AI akan otomatis bikin URL pencarian berdasarkan role + stack kamu:

```bash
# Contoh untuk Fullstack Developer dengan Laravel + React:
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer+Laravel+React&location=Jakarta&f_AL=true"

# Atau spesifik:
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=Laravel+developer&location=Jakarta&f_AL=true"

# Remote:
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer&location=Remote&f_AL=true&f_WT=2"
```

**Parameter penting:**
- `keywords` = role + stack kamu (dari CV)
- `location` = kota target
- `f_AL=true` = filter Easy Apply aja (biar cepet)
- `f_WT=2` = remote only
- `f_WT=1,2,3` = on-site + remote + hybrid

---

## Step 3: Lamar Satu per Satu

Untuk setiap lowongan di hasil pencarian:

### A. Klik Lowongan
```bash
browser-act --session main state
# Cari job card, klik
```

### B. Cek Tipe Lamaran
```bash
browser-act --session main state
# Cari:
#   "Melamar Mudah" → Easy Apply
#   "Lamar di website perusahaan" → External Apply
```

### C1. Easy Apply — Isi & Kirim
```
1. Klik "Melamar Mudah"
2. Isi nomor HP → dari profile.json
3. Jawab screening questions:
   - Text → ketik jawaban
   - Dropdown → pilih opsi
   - Yes/No → klik radio
   - Gaji → isi sesuai range (atau "Negotiable")
4. Klik "Lanjutkan" sampai halaman terakhir
5. Kalau muncul Premium upsell → klik "Lewati" / close (×)
6. Klik "Kirim lamaran"
7. ✅ Catat sebagai TERKIRIM
```

### C2. External Apply — Isi Form Eksternal
```
1. Klik "Lamar di website perusahaan"
2. Tab baru terbuka → isi form:
   a. Upload CV → dari resume_path di profile.json
   b. Nama → dari profile.json
   c. Email → dari profile.json
   d. Phone → dari profile.json
   e. Headline → dari profile.json
3. Submit
4. ⏳ Catat sesuai kondisi:
   - ✅ Terkirim kalau berhasil
   - ⏳ Partial kalau form ribet (multi-page, login required)
```

---

## Step 4: Catat Hasil

Semua hasil ditulis ke `LAMARAN.md`:

```markdown
## PT Nama Perusahaan - Posisi
- **Tanggal**: 2026-07-06
- **Platform**: LinkedIn
- **Tipe**: Easy Apply / External
- **Link**: https://linkedin.com/jobs/view/xxx
- **Status**: ✅ Terkirim / ⏳ Partial / ❌ Gagal
- **Catatan**: Butuh verifikasi email
```

---

## Strategi Supaya Cepat Dapet Panggilan

### 1. Prioritaskan Easy Apply
Filter `f_AL=true` — proses 5-10 lamaran per jam vs 2-3 untuk external.

### 2. Variasi Kata Kunci
Jangan cuma satu kata kunci. Coba variasi:

| Stack Kamu | Cari Juga |
|------------|-----------|
| Laravel | PHP Developer, Backend Laravel, Fullstack PHP |
| Next.js | React Developer, Frontend Next.js, Fullstack JavaScript |
| React | Frontend Developer, React JS, JavaScript Engineer |
| DevOps | Site Reliability Engineer, Infrastructure Engineer |

### 3. Target Banyak Kota & Remote
```bash
# Jakarta
?keywords=fullstack&location=Jakarta
# Remote Indonesia
?keywords=fullstack&location=Remote&f_WT=2
# Bandung
?keywords=fullstack&location=Bandung
```

### 4. Apply Baru (Urutkan)
```bash
# Filter: diposting dalam 24 jam terakhir
&f_TPR=r86400
# Atau 1 minggu
&f_TPR=r604800
```

### 5. Lamaran Massal dalam 1 Sesi
Prosesnya: buka LinkedIn → cari → buka lowongan 1 → apply → back → lowongan 2 → apply → ... sampai 20+

---

## Contoh Sesi Auto-Apply

```bash
# 1. Buka LinkedIn
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer+Laravel+React&location=Jakarta&f_AL=true"
browser-act --session main wait stable

# 2. Loop: klik job → check → apply → back → next
# AI akan lakukan ini otomatis berdasarkan state page

# 3. Cek hasil
cat LAMARAN.md
```

---

## Tips Lanjutan

- **Gunakan 2 session** — 1 untuk LinkedIn, 1 untuk Magentaku (biar gak campur)
- **Jeda antar lamaran** — biar gak kelihatan kayak bot (tunggu 5-10 detik)
- **Cek hasil** — sesekali buka `LAMARAN.md` dan pantau progress
- **Update CV berkala** — pakai `scripts/generate_cv.py` setiap kali ada pengalaman baru
- **Maksimal 20 lamaran/hari** — biar kualitas terjaga dan LinkedIn gak restrict akun

---

## Ada Masalah? Jalanin Ulang Aja

Error di tengah jalan? Gak papa:

```bash
# Cek udah sampe mana
cat LAMARAN.md | grep -c "Terkirim"

# Lanjut dari lowongan berikutnya
browser-act --session main state
# Klik job card berikutnya, lanjut apply
```
