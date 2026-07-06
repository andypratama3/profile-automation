# Pola-Pola Umum Automation

Teknik reusable untuk automation web apa pun.

## Daftar Isi

1. [Interaksi DOM](#interaksi-dom)
2. [Select2 Dropdown](#select2-dropdown)
3. [flatpickr Tanggal](#flatpickr-tanggal)
4. [Upload File](#upload-file)
5. [Modal](#modal)
6. [Validasi Form](#validasi-form)
7. [Session Management](#session-management)
8. [Debugging](#debugging)

---

## Interaksi DOM

```bash
browser-act --session main click 5        # Klik element index 5
browser-act --session main input 3 "teks" # Ketik ke input 3
browser-act --session main state          # Lihat state page
browser-act --session main eval 'JS'      # Jalanin JavaScript
```

---

## Select2 Dropdown

```javascript
// Set value
window.jQuery("[name=type]").val("value").trigger("change");

// Cari di dropdown yang terbuka
$("select").data("select2").dropdown.$search.val("cari").trigger("keyup");

// Multiple select (skills)
var s = document.querySelector("select[name='skill_ids[]']");
Array.from(s.options).filter(o => o.text.includes("PHP")).forEach(o => o.selected = true);
window.jQuery(s).trigger("change");
```

---

## flatpickr Tanggal

```javascript
// SELALU pake API flatpickr, jangan set value langsung
document.getElementById("tgl_mulai")._flatpickr.setDate("2024-11-01");
```

---

## Upload File

```javascript
var input = document.querySelector("input[type=file]");
var dt = new DataTransfer();
dt.items.add(new File([""], "file.pdf", {type: "application/pdf"}));
input.files = dt.files;
input.dispatchEvent(new Event("change", {bubbles: true}));
```

---

## Modal

```javascript
// SweetAlert2
document.querySelector(".swal2-confirm").click();

// Bootstrap
document.querySelector(".btn-close").click();
```

---

## Validasi Form

```javascript
// Trigger change detection
element.value = "xxx";
element.dispatchEvent(new Event("input", {bubbles: true}));
element.dispatchEvent(new Event("change", {bubbles: true}));
```

---

## Session Management

```bash
# Buat session
browser-act --session main chrome-direct

# Kalau Chrome mati:
./scripts/start-chrome.sh
browser-act --session main chrome-direct
```

---

## Debugging

```bash
browser-act --session main state          # Cek keadaan halaman
browser-act --session main get markdown   # Extract konten
browser-act --session main screenshot     # Screenshot
```
