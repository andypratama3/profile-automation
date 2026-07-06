# Generate CV ATS

Buat CV Word/PDF profesional dari data kamu.

## Cara

```bash
python scripts/generate_cv.py --data data/profile.json --output cv_saya.docx
```

## Hasil

CV akan berisi:
- Nama & kontak
- Ringkasan profesional
- Pengalaman kerja
- Pendidikan
- Sertifikasi
- Skill

## Upload ke Platform

```bash
# Magentaku
browser-act --session main go https://magentaku.id/profil/cv

# LinkedIn
browser-act --session main go https://linkedin.com/in/namakamu/edit
```
