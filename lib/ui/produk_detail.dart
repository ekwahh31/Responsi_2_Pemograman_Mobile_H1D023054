import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket1_h1d023054/bloc/produk_bloc.dart';
import 'package:responsi2_mobile_paket1_h1d023054/model/produk.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/produk_form.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/produk_page.dart';
import 'package:responsi2_mobile_paket1_h1d023054/widget/warning_dialog.dart';
// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Detail Komputer Eka',
          style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.computer, size: 64, color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      _buildDetailRow(Icons.label, "Nama", widget.produk!.nama!),
                      const Divider(height: 32),
                      _buildDetailRow(Icons.attach_money, "Harga", "Rp ${widget.produk!.harga}"),
                      const Divider(height: 32),
                      _buildDetailRow(Icons.inventory_2, "Jumlah", "${widget.produk!.jumlah} unit"),
                      const Divider(height: 32),
                      _buildDetailRow(Icons.calendar_today, "Tanggal Masuk", widget.produk!.tanggal_masuk!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.grey[700], size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.edit),
            label: const Text("Edit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdukForm(produk: widget.produk!),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.delete),
            label: const Text("Hapus", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.warning, color: Colors.orange[700]),
          const SizedBox(width: 8),
          const Text("Konfirmasi"),
        ],
      ),
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: const Text("Batal", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            foregroundColor: Colors.white,
          ),
          child: const Text("Ya, Hapus", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
              (value) => {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProdukPage()),
                ),
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
