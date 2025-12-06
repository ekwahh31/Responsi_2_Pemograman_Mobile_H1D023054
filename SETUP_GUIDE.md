# Panduan Lengkap Setup & Menjalankan Aplikasi

## Aplikasi Inventaris Komputer H1D023054

### 📋 Checklist Persiapan

- [ ] Flutter SDK terinstall
- [ ] Android Studio / VS Code terinstall
- [ ] Laragon terinstall (untuk API backend)
- [ ] Emulator Android atau device fisik ready

---

## 🚀 Langkah-Langkah Setup

### STEP 1: Setup Backend API

#### 1.1 Copy API ke Laragon
```bash
# Copy folder simple_api ke:
C:\laragon\www\toko_api\
```

#### 1.2 Start Laragon
- Buka Laragon
- Klik "Start All"
- Pastikan Apache dan MySQL berwarna hijau

#### 1.3 Import Database
1. Buka browser: `http://localhost/phpmyadmin`
2. Login (default: username=root, password=kosong)
3. Klik "New" untuk buat database
4. Nama database: `toko_api`
5. Klik tab "Import"
6. Choose file: pilih `simple_api/database.sql`
7. Klik "Go"

#### 1.4 Test API
Buka browser: `http://localhost/toko_api/`

Jika muncul:
```json
{"message":"API Toko - Inventaris Komputer"}
```
Berarti API sudah running! ✅

---

### STEP 2: Setup Flutter App

#### 2.1 Install Dependencies
```bash
cd C:\laragon\www\responsi2_mobile_paket1_h1d023054
flutter pub get
```

#### 2.2 Konfigurasi API URL

Edit file: `lib/helpers/api_url.dart`

**Untuk Emulator Android:**
```dart
static const String baseUrl = 'http://10.0.2.2/toko_api';
```

**Untuk Device Fisik:**
```dart
static const String baseUrl = 'http://192.168.X.X/toko_api';
```
*(Ganti dengan IP komputer Anda - lihat cara di bawah)*

**Cara mendapatkan IP komputer:**
```cmd
ipconfig
```
Lihat di "IPv4 Address"

---

### STEP 3: Jalankan Aplikasi

#### 3.1 Check Devices
```bash
flutter devices
```

#### 3.2 Run App
```bash
# Untuk emulator/device tertentu
flutter run -d <device-id>

# Atau langsung run (akan pilih device otomatis)
flutter run
```

#### 3.3 Hot Reload
- Saat app running, tekan `r` untuk hot reload
- Tekan `R` untuk hot restart
- Tekan `q` untuk quit

---

## 🧪 Testing Aplikasi

### Test 1: Registrasi
1. Buka aplikasi
2. Klik "Registrasi"
3. Isi form:
   - Nama: Test User
   - Email: test@test.com
   - Password: password123
   - Konfirmasi Password: password123
4. Klik "Registrasi"
5. Jika berhasil, akan muncul dialog "Registrasi berhasil"

### Test 2: Login
1. Di halaman login:
   - Email: test@test.com
   - Password: password123
2. Klik "Login"
3. Jika berhasil, akan masuk ke halaman utama

### Test 3: Tambah Komputer
1. Klik icon "+" di AppBar
2. Isi form:
   - Nama Komputer: Laptop ASUS
   - Harga: 15000000
   - Jumlah: 5
   - Tanggal Masuk: klik calendar icon, pilih tanggal
3. Klik "SIMPAN"
4. Data akan muncul di list

### Test 4: Lihat Detail
1. Klik salah satu item komputer
2. Detail akan ditampilkan

### Test 5: Edit Komputer
1. Buka detail komputer
2. Klik "EDIT"
3. Ubah data (misal: jumlah jadi 3)
4. Klik "UBAH"

### Test 6: Hapus Komputer
1. Buka detail komputer
2. Klik "DELETE"
3. Konfirmasi dengan klik "Ya"

### Test 7: Logout
1. Buka drawer menu (☰)
2. Klik "Logout"
3. Akan kembali ke halaman login

---

## ❗ Troubleshooting

### Problem: Connection Refused

**Solusi:**
1. Pastikan Laragon running
2. Test buka: `http://localhost/toko_api/`
3. Untuk Android emulator, pastikan pakai `10.0.2.2` bukan `localhost`
4. Untuk device fisik, pastikan HP dan laptop di jaringan WiFi yang sama

### Problem: SocketException

**Solusi:**
1. Cek koneksi internet/WiFi
2. Disable firewall sementara
3. Untuk device fisik, allow firewall untuk port 80

### Problem: Login Failed

**Solusi:**
1. Test API dengan Postman/Thunder Client dulu
2. Cek database users, apakah data sudah masuk
3. Lihat log error di console Flutter

### Problem: Database Error

**Solusi:**
1. Pastikan database `toko_api` sudah dibuat
2. Pastikan semua tabel sudah dibuat (users, produk)
3. Re-import database.sql

### Problem: Flutter Error

**Solusi:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📱 Testing dengan Postman (Opsional)

### Test Registrasi
```
POST http://localhost/toko_api/registrasi
Content-Type: application/json

{
  "nama": "John Doe",
  "email": "john@test.com",
  "password": "123456"
}
```

### Test Login
```
POST http://localhost/toko_api/login
Content-Type: application/json

{
  "email": "john@test.com",
  "password": "123456"
}
```

### Test Get Produk
```
GET http://localhost/toko_api/produk
```

### Test Create Produk
```
POST http://localhost/toko_api/produk
Content-Type: application/json

{
  "nama": "Laptop Dell",
  "harga": "15000000",
  "jumlah": "5",
  "tanggal_masuk": "2024-12-06"
}
```

---

## 📊 Struktur Database

### Tabel: users
| Field | Type | Note |
|-------|------|------|
| id | INT | Primary Key |
| nama | VARCHAR(100) | Nama user |
| email | VARCHAR(100) | Email (unique) |
| password | VARCHAR(255) | Hashed password |
| created_at | TIMESTAMP | Auto timestamp |

### Tabel: produk
| Field | Type | Note |
|-------|------|------|
| id | INT | Primary Key |
| nama | VARCHAR(200) | Nama komputer |
| harga | INT | Harga |
| jumlah | INT | Stok |
| tanggal_masuk | DATE | Tanggal masuk |
| created_at | TIMESTAMP | Auto timestamp |
| updated_at | TIMESTAMP | Auto timestamp |

---

## 🎨 Fitur Aplikasi

✅ **Authentication**
- Login dengan validasi
- Registrasi user baru
- Session management
- Logout

✅ **CRUD Komputer**
- Create: Tambah komputer baru
- Read: List & detail komputer
- Update: Edit data komputer
- Delete: Hapus komputer

✅ **UI/UX**
- Grey color theme
- Custom action bar dengan nama
- Date picker untuk tanggal
- Form validation
- Loading indicator
- Error handling
- Confirmation dialog

---

## 📝 Catatan Penting

1. **API Backend harus running sebelum aplikasi**
2. **Gunakan IP yang benar sesuai platform**
3. **Pastikan database sudah di-import**
4. **Test API dengan Postman/browser dulu**
5. **Untuk production, gunakan HTTPS dan JWT**

---

## 🎓 Untuk Pengumpulan

Pastikan:
- [ ] Aplikasi bisa registrasi
- [ ] Aplikasi bisa login
- [ ] CRUD komputer berfungsi
- [ ] Warna abu-abu sudah diterapkan
- [ ] Nama di action bar sesuai (H1D023054)
- [ ] Screenshot aplikasi sudah dibuat
- [ ] API backend included
- [ ] README.md lengkap

---

## 📞 Support

Jika ada masalah:
1. Cek console/log error
2. Test API dengan Postman
3. Lihat troubleshooting di atas
4. Check database connection

---

**Good Luck! 🚀**

*Aplikasi Inventaris Komputer - Responsi 2 Mobile Paket 1*
