import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket1_h1d023054/bloc/produk_bloc.dart';
import 'package:responsi2_mobile_paket1_h1d023054/model/produk.dart';
import 'package:responsi2_mobile_paket1_h1d023054/ui/produk_page.dart';
import 'package:responsi2_mobile_paket1_h1d023054/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH KOMPUTER EKA";
  String tombolSubmit = "SIMPAN";
  final _namaTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "EDIT KOMPUTER EKA";
        tombolSubmit = "EDIT";
        _namaTextboxController.text = widget.produk!.nama!;
        _hargaTextboxController.text = widget.produk!.harga.toString();
        _jumlahTextboxController.text = widget.produk!.jumlah.toString();
        _tanggalMasukTextboxController.text = widget.produk!.tanggal_masuk!;
      });
    } else {
      judul = "TAMBAH KOMPUTER EKA";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(
                widget.produk == null ? Icons.add_circle : Icons.edit,
                size: 64,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 16),
              Text(
                widget.produk == null ? 'Tambah Data Komputer' : 'Edit Data Komputer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _namaTextField(),
                        const SizedBox(height: 20),
                        _hargaTextField(),
                        const SizedBox(height: 20),
                        _jumlahTextField(),
                        const SizedBox(height: 20),
                        _tanggalMasukTextField(),
                        const SizedBox(height: 30),
                        _buttonSubmit(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Nama Komputer
  Widget _namaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Komputer",
        prefixIcon: Icon(Icons.computer, color: Colors.grey[600]),
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Komputer harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga
  Widget _hargaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        prefixIcon: Icon(Icons.attach_money, color: Colors.grey[600]),
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Jumlah
  Widget _jumlahTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah",
        prefixIcon: Icon(Icons.inventory_2, color: Colors.grey[600]),
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Tanggal Masuk
  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Masuk",
        prefixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
        labelStyle: TextStyle(color: Colors.grey[700]),
        hintText: "Contoh: 31 Maret 2005",
      ),
      keyboardType: TextInputType.text,
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Masuk harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
          ),
          icon: Icon(widget.produk == null ? Icons.save : Icons.update),
          label: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(tombolSubmit, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          onPressed: () {
            var validate = _formKey.currentState!.validate();
            if (validate) {
              if (!_isLoading) {
                if (widget.produk != null) {
                  //kondisi update produk
                  ubah();
                } else {
                  //kondisi tambah produk
                  simpan();
                }
              }
            }
          }),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.nama = _namaTextboxController.text;
    createProduk.harga = int.parse(_hargaTextboxController.text);
    createProduk.jumlah = int.parse(_jumlahTextboxController.text);
    createProduk.tanggal_masuk = _tanggalMasukTextboxController.text;
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.nama = _namaTextboxController.text;
    updateProduk.harga = int.parse(_hargaTextboxController.text);
    updateProduk.jumlah = int.parse(_jumlahTextboxController.text);
    updateProduk.tanggal_masuk = _tanggalMasukTextboxController.text;
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
