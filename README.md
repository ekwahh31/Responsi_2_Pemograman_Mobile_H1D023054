# Responsi 2 Mobile Paket 1 (H1D023054)

Aplikasi Inventaris Komputer untuk Supermarket - Sistem pencatatan inventaris barang kategori Komputer.

## Fitur Aplikasi

✅ **Login & Registrasi**
- Autentikasi pengguna dengan email dan password
- Validasi form dan error handling
- Session management dengan SharedPreferences

✅ **CRUD Inventaris Komputer**
- **Create**: Tambah data komputer baru
- **Read**: Lihat daftar dan detail komputer
- **Update**: Edit data komputer
- **Delete**: Hapus data komputer

✅ **Data yang Dicatat**
- Nama Komputer (string)
- Harga (integer)
- Jumlah/Stok (integer)
- Tanggal Masuk (date picker)

✅ **Desain**
- Warna utama: Abu-abu (Grey Theme)
- Action Bar dengan nama: "Inventaris Komputer H1D023054"
- UI/UX yang user-friendly

## Screenshot

(Tambahkan screenshot aplikasi Anda di sini)

## Teknologi yang Digunakan

- **Flutter SDK**: ^3.9.2
- **Dart**: ^3.9.2
- **Dependencies**:
  - `http`: ^1.1.0 - HTTP request
  - `shared_preferences`: ^2.2.2 - Local storage
  - `intl`: ^0.19.0 - Date formatting
  - `cupertino_icons`: ^1.0.8 - iOS style icons

## Struktur Aplikasi

```
lib/
├── bloc/                  # Business Logic Components
│   ├── login_bloc.dart
│   ├── registrasi_bloc.dart
│   ├── produk_bloc.dart
│   └── logout_bloc.dart
├── helpers/               # Helper Classes
│   ├── api.dart
│   ├── api_url.dart
│   └── user_info.dart
├── model/                 # Data Models
│   ├── login.dart
│   ├── registrasi.dart
│   └── produk.dart
├── ui/                    # User Interface
│   ├── login_page.dart
│   ├── registrasi_page.dart
│   ├── produk_page.dart
│   ├── produk_form.dart
│   └── produk_detail.dart
├── widget/                # Custom Widgets
│   ├── warning_dialog.dart
│   └── success_dialog.dart
└── main.dart              # Entry Point
```

## Instalasi & Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd responsi2_mobile_paket1_h1d023054
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Backend API

Lihat file `API_DOCUMENTATION.md` untuk:
- Setup database
- Endpoint API yang diperlukan
- Konfigurasi server

### 4. Konfigurasi API URL

Edit file `lib/helpers/api_url.dart`:

```dart
static const String baseUrl = 'http://YOUR_IP_ADDRESS/toko_api/public';
```

**Catatan**:
- Emulator Android: `http://10.0.2.2`
- Device fisik: IP komputer Anda (misal: `http://192.168.1.100`)
- iOS Simulator: `http://localhost`

### 5. Jalankan Aplikasi

```bash
# Check device
flutter devices

# Run aplikasi
flutter run
```

## Cara Menggunakan Aplikasi

### 1. Registrasi
- Buka aplikasi
- Klik "Registrasi"
- Isi Nama, Email, Password, dan Konfirmasi Password
- Klik tombol "Registrasi"

### 2. Login
- Masukkan Email dan Password
- Klik tombol "Login"

### 3. Tambah Komputer
- Di halaman utama, klik icon "+"
- Isi form:
  - Nama Komputer
  - Harga
  - Jumlah
  - Tanggal Masuk (klik untuk date picker)
- Klik "SIMPAN"

### 4. Lihat Detail
- Klik salah satu item komputer dari list
- Detail akan ditampilkan

### 5. Edit Komputer
- Buka detail komputer
- Klik tombol "EDIT"
- Ubah data yang diperlukan
- Klik "UBAH"

### 6. Hapus Komputer
- Buka detail komputer
- Klik tombol "DELETE"
- Konfirmasi penghapusan

### 7. Logout
- Buka menu drawer (☰)
- Klik "Logout"

## Model Data

### Produk (Komputer)
```dart
class Produk {
  String? id;
  String? nama;           // Nama komputer
  var harga;              // Harga (integer)
  var jumlah;             // Jumlah stok (integer)
  String? tanggal_masuk;  // Tanggal masuk (YYYY-MM-DD)
}
```

### Login
```dart
class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;
}
```

### Registrasi
```dart
class Registrasi {
  int? code;
  bool? status;
  String? data;
}
```

## Fitur Tambahan

- ✅ Date Picker untuk tanggal masuk
- ✅ Form validation
- ✅ Loading indicator
- ✅ Error handling dengan dialog
- ✅ Drawer menu
- ✅ Responsive UI
- ✅ Grey theme konsisten

## Troubleshooting

### Error: Connection Refused
- Pastikan API backend sudah berjalan
- Cek konfigurasi URL di `api_url.dart`
- Untuk Android emulator, gunakan `10.0.2.2` bukan `localhost`

### Error: Certificate Verification Failed
- Untuk development, pastikan menggunakan HTTP bukan HTTPS
- Atau konfigurasi SSL certificate dengan benar

### Error: Dependencies
```bash
flutter clean
flutter pub get
```

## Developer

**NIM**: H1D023054

## Catatan Penting

⚠️ **API Backend Terpisah**
- Aplikasi ini membutuhkan API backend
- Lihat `API_DOCUMENTATION.md` untuk setup API
- Framework backend dibebaskan (Laravel, Node.js, dll)

⚠️ **Testing**
- Test di emulator Android/iOS
- Test di device fisik
- Pastikan koneksi internet aktif

## Lisensi

Project ini dibuat untuk keperluan akademik.

---

**Responsi 2 Mobile - Paket 1**  
Aplikasi Inventaris Komputer dengan Flutter


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
