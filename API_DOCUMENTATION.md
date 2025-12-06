# API Backend untuk Aplikasi Inventaris Komputer

## Setup Database

Buat database dengan nama `toko_api` dan jalankan SQL berikut:

```sql
CREATE DATABASE toko_api;

USE toko_api;

-- Tabel Users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Produk (Komputer)
CREATE TABLE produk (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(200) NOT NULL,
    harga INT NOT NULL,
    jumlah INT NOT NULL,
    tanggal_masuk DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## Setup Laravel API (Opsional)

Jika menggunakan Laravel, jalankan:

```bash
composer create-project laravel/laravel toko_api
cd toko_api
```

Kemudian setup routes, controllers, dan models sesuai dengan endpoint berikut.

## Endpoint API yang Dibutuhkan

### 1. Registrasi
- **URL**: `POST /registrasi`
- **Body**:
  ```json
  {
    "nama": "string",
    "email": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": "Registrasi berhasil"
  }
  ```

### 2. Login
- **URL**: `POST /login`
- **Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": {
      "token": "string",
      "user": {
        "id": "1",
        "email": "user@example.com"
      }
    }
  }
  ```

### 3. Get All Produk
- **URL**: `GET /produk`
- **Response**:
  ```json
  {
    "status": true,
    "data": [
      {
        "id": "1",
        "nama": "Laptop Dell",
        "harga": 15000000,
        "jumlah": 10,
        "tanggal_masuk": "2024-01-15"
      }
    ]
  }
  ```

### 4. Create Produk
- **URL**: `POST /produk`
- **Body**:
  ```json
  {
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "YYYY-MM-DD"
  }
  ```
- **Response**:
  ```json
  {
    "status": true,
    "data": "Data berhasil ditambahkan"
  }
  ```

### 5. Update Produk
- **URL**: `PUT /produk/{id}/update`
- **Body**:
  ```json
  {
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "YYYY-MM-DD"
  }
  ```
- **Response**:
  ```json
  {
    "status": true,
    "data": "Data berhasil diupdate"
  }
  ```

### 6. Delete Produk
- **URL**: `DELETE /produk/{id}/delete`
- **Response**:
  ```json
  {
    "status": true,
    "data": "Data berhasil dihapus"
  }
  ```

## Konfigurasi

Ubah base URL di file `lib/helpers/api_url.dart` sesuai dengan server Anda:

```dart
static const String baseUrl = 'http://YOUR_IP_ADDRESS/toko_api/public';
```

**Catatan**:
- Untuk emulator Android: gunakan `http://10.0.2.2`
- Untuk device fisik: gunakan IP address komputer Anda (misal: `http://192.168.1.100`)
- Untuk iOS simulator: gunakan `http://localhost`

## Testing dengan Postman

Import collection berikut ke Postman untuk testing API:

1. Registrasi
2. Login
3. CRUD Produk

Pastikan API sudah berjalan sebelum menjalankan aplikasi Flutter.
