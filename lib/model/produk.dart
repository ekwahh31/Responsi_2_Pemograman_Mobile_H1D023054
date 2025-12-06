class Produk {
  String? id;
  String? nama;
  var harga;
  var jumlah;
  String? tanggal_masuk;
  Produk({this.id, this.nama, this.harga, this.jumlah, this.tanggal_masuk});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'],
      nama: obj['nama'],
      harga: obj['harga'],
      jumlah: obj['jumlah'],
      tanggal_masuk: obj['tanggal_masuk'],
    );
  }
}