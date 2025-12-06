# INSTRUKSI COPY API KE LARAGON

## Langkah-langkah Setup API Backend

### 1. Copy Folder API

Anda perlu copy folder `simple_api` ke direktori web server Laragon:

**Dari:**
```
C:\laragon\www\responsi2_mobile_paket1_h1d023054\simple_api\
```

**Ke:**
```
C:\laragon\www\toko_api\
```

### 2. Cara Copy (Windows)

#### Opsi A: Copy Manual
1. Buka File Explorer
2. Navigate ke: `C:\laragon\www\responsi2_mobile_paket1_h1d023054\`
3. Copy folder `simple_api`
4. Navigate ke: `C:\laragon\www\`
5. Paste dan rename folder menjadi `toko_api`

#### Opsi B: Via Command Line (PowerShell)
```powershell
# Buka PowerShell as Administrator
# Jalankan command berikut:

# Buat folder toko_api
New-Item -Path "C:\laragon\www\toko_api" -ItemType Directory -Force

# Copy semua file dari simple_api ke toko_api
Copy-Item -Path "C:\laragon\www\responsi2_mobile_paket1_h1d023054\simple_api\*" -Destination "C:\laragon\www\toko_api\" -Recurse -Force
```

### 3. Verifikasi

Setelah copy, struktur folder harus seperti ini:
```
C:\laragon\www\toko_api\
├── index.php
├── database.sql
├── .htaccess
└── README.md
```

### 4. Start Laragon

1. Buka aplikasi Laragon
2. Klik tombol "Start All"
3. Tunggu sampai Apache dan MySQL berwarna hijau

### 5. Import Database

1. Buka browser
2. Akses: `http://localhost/phpmyadmin`
3. Login:
   - Username: `root`
   - Password: (kosong)
4. Klik "New" untuk buat database baru
5. Nama database: `toko_api`
6. Collation: `utf8mb4_general_ci`
7. Klik "Create"
8. Pilih database `toko_api`
9. Klik tab "Import"
10. Click "Choose File"
11. Pilih: `C:\laragon\www\toko_api\database.sql`
12. Scroll ke bawah, klik "Go"
13. Tunggu sampai selesai

### 6. Test API

Buka browser dan akses:
```
http://localhost/toko_api/
```

Jika berhasil, akan muncul:
```json
{"message":"API Toko - Inventaris Komputer"}
```

### 7. Test Endpoint

#### Test Get Produk
```
http://localhost/toko_api/produk
```

Seharusnya menampilkan data sample komputer.

### 8. Troubleshooting

#### Error: 404 Not Found
**Solusi:**
- Pastikan folder ada di `C:\laragon\www\toko_api\`
- Pastikan file `index.php` dan `.htaccess` ada
- Restart Laragon

#### Error: Database Connection Failed
**Solusi:**
- Pastikan MySQL di Laragon sudah running (warna hijau)
- Cek database `toko_api` sudah dibuat
- Cek file `index.php`, konfigurasi database:
  ```php
  define('DB_HOST', 'localhost');
  define('DB_USER', 'root');
  define('DB_PASS', '');
  define('DB_NAME', 'toko_api');
  ```

#### Error: Can't import database
**Solusi:**
- Buat database `toko_api` manual dulu
- Buka file `database.sql` dengan text editor
- Copy semua SQL
- Paste di tab SQL di phpMyAdmin
- Klik "Go"

### 9. Konfigurasi Flutter App

Setelah API running, edit file Flutter:

**File:** `lib/helpers/api_url.dart`

**Untuk Emulator Android:**
```dart
static const String baseUrl = 'http://10.0.2.2/toko_api';
```

**Untuk Device Fisik:**
```dart
static const String baseUrl = 'http://192.168.X.X/toko_api';
```
*(Ganti X.X dengan IP komputer Anda)*

**Cara cek IP komputer:**
```cmd
ipconfig
```
Lihat di "IPv4 Address"

### 10. Test dari Flutter

Setelah semua setup:
```bash
flutter pub get
flutter run
```

Test flow:
1. Registrasi user baru
2. Login
3. Tambah komputer
4. Lihat list
5. Edit komputer
6. Hapus komputer

---

## Quick Commands (PowerShell)

Copy paste semua command ini ke PowerShell:

```powershell
# Copy API ke Laragon
New-Item -Path "C:\laragon\www\toko_api" -ItemType Directory -Force
Copy-Item -Path "C:\laragon\www\responsi2_mobile_paket1_h1d023054\simple_api\*" -Destination "C:\laragon\www\toko_api\" -Recurse -Force

Write-Host "API berhasil di-copy ke C:\laragon\www\toko_api\" -ForegroundColor Green
Write-Host "Selanjutnya:" -ForegroundColor Yellow
Write-Host "1. Start Laragon" -ForegroundColor Cyan
Write-Host "2. Import database.sql di phpMyAdmin" -ForegroundColor Cyan
Write-Host "3. Test: http://localhost/toko_api/" -ForegroundColor Cyan
```

---

**Setelah setup selesai, API siap digunakan! 🚀**
