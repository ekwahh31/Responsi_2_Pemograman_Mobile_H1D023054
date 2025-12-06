class ApiUrl {
  static const String baseUrl = 'http://localhost:8080';
  
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';

   static String updateProduk(String id) {
    return baseUrl + '/produk/' + id;
  }

  static String showProduk(String id) {
    return baseUrl + '/produk/' + id;
  }

  static String deleteProduk(String id) {
    return baseUrl + '/produk/' + id;
  }
}
