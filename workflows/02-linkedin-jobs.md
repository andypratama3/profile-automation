# LinkedIn Job Application (Manual)

Panduan manual untuk melamar kerja di LinkedIn — kalau mau milih lowongan sendiri.

## Data Kamu

Semua data dibaca dari `data/profile.json`.

## Langkah

### 1. Cari Lowongan

```bash
browser-act --session main go "https://www.linkedin.com/jobs/search/?keywords=fullstack+developer&location=Jakarta&f_AL=true"
browser-act --session main wait stable
```

### 2. Klik Lowongan

```bash
browser-act --session main state
# Cari job card, klik salah satu
```

### 3. Cek Tipe Lamaran

```bash
browser-act --session main state
# "Melamar Mudah" → Easy Apply
# "Lamar di website perusahaan" → External
```

### Easy Apply
1. Klik "Melamar Mudah"
2. Isi nomor HP dari `profile.json`
3. Jawab screening questions
4. Klik "Lanjutkan" sampai selesai
5. Klik "Kirim lamaran"

### External Apply
1. Klik "Lamar di website perusahaan"
2. Di tab baru, isi form eksternal:
   - Upload CV, Nama, Email, No HP
3. Submit

### 4. Catat Hasil

Tambahin ke `LAMARAN.md`:

```markdown
## PT Nama - Posisi
- **Tanggal**: 2026-07-06
- **Tipe**: Easy Apply
- **Status**: ✅ Terkirim
```

## Tips

- Filter `f_AL=true` biar cuma Easy Apply
- Filter `f_WT=2` untuk remote
- Urutkan `f_TPR=r86400` untuk 24 jam terakhir
