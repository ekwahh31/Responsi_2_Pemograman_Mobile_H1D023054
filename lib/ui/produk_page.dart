import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket1_h1d023054/bloc/logout_bloc.dart';
import 'package:responsi2_mobile_paket1_h1d023054/bloc/produk_bloc.dart';
import 'package:responsi2_mobile_paket1_h1d023054/model/produk.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/login_page.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/produk_detail.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Inventaris Komputer Eka',
          style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.add_circle, size: 28.0),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
              tooltip: 'Tambah Komputer',
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey[800]!, Colors.grey[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.computer, size: 48, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    'Inventaris Komputer',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Eka Bintang Wicaksono H1D023054',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.inventory, color: Colors.grey[700]),
              title: const Text('List Komputer', style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.grey[700]),
              title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () async {
                await LogoutBloc.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Produk>>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Produk>? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemProduk(
          produk: list![i],
        );
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.computer, color: Colors.white, size: 28),
              ),
              title: Text(
                produk.nama!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_money, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text("Rp ${produk.harga}", style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.inventory_2, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text("${produk.jumlah} unit", style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(produk.tanggal_masuk!, style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ],
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_forward_ios, color: Colors.grey[700], size: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
