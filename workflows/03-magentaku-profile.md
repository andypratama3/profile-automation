# Update Profil Magentaku ID

Panduan update profil Magentaku ID secara otomatis.

## Halaman

| Bagian | URL | Level |
|--------|-----|-------|
| Data Pribadi | `/profil/data-pribadi` | Mudah |
| Pengalaman | `/profil/data-akademik/edit` | Sulit |
| Pendidikan | `/profil/data-akademik/edit` | Sedang |
| Sertifikasi | `/profil/data-akademik/edit` | Sedang |
| Keahlian | `/profil/data-akademik/edit` | Sedang |
| Data Keluarga | `/profil/data-family` | Mudah |
| Dokumen | `/profil/cv` | Sedang |

## Data Pribadi

```bash
browser-act --session main go https://magentaku.id/profil/data-pribadi
```

Isi `about` (textarea), nama, NIK, no HP, email, alamat, sosmed dari `data/profile.json`.

## Pengalaman (Work Experience)

```bash
browser-act --session main go https://magentaku.id/profil/data-akademik/edit
```

**Untuk tiap pengalaman:**
1. Klik "Tambah Pengalaman"
2. Isi jabatan, perusahaan, jenis, tanggal, deskripsi
3. Submit, dismiss modal, ulangi

## Sertifikasi

```bash
# Klik "Tambah Lisensi dan Sertifikasi", lalu isi:
document.getElementById("name").value = "Nama Sertifikasi";
document.getElementById("publisher").value = "Penerbit";
document.getElementById("published_at")._flatpickr.setDate("2024-01-01");
document.getElementById("submitCertification").click();
```

## Keahlian (Skills)

Pake Select2 multiselect. Cari skill berdasarkan nama, klik, simpan.

## Dokumen

Upload file KTP, CV, Sertifikat, Transkrip, dll lewat form upload.
