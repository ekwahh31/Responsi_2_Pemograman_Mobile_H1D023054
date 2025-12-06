# RESPONSI 2 PEMOGRAMAN MOBILE PAKET 1 INVENTARIS KOMPUTER
EKA BINTANG WICAKSONO<br>
H1D023054<br>
SHIFT KRS B<br>
SHIFT BARU A<br>
<br>

# DEMO APLIKASI
https://github.com/user-attachments/assets/eb67c794-4663-4173-bb6f-b30de2b2a813

# PENJELASAN FUNGSI KODE DALAM APLIKASI
## Main
``main.dart``
```
void main() {
  runApp(const MyApp());
}
```
Penjelasan: Entry point aplikasi, jalankan MyApp widget

```
MaterialApp(
  title: 'Responsi 2 Mobile Paket 1 (H1D023054)',
  theme: ThemeData(
    primarySwatch: Colors.grey,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.grey,
      primary: Colors.grey[800]!,
    ),
  ),
  home: const LoginPage(),
)
```
Penjelasan: Setup aplikasi dengan tema abu-abu dan halaman awal Login

## Models
``login.dart``
```
factory Login.fromJson(Map<String, dynamic> obj) {
  return Login(
    code: obj['code'],
    status: obj['status'],
    token: obj['data']['token'],
    userID: int.parse(obj['data']['user']['id']),
    userEmail: obj['data']['user']['email']
  );
}
```
Penjelasan: Convert JSON dari API jadi object Login

``produk.dart``
```
factory Produk.fromJson(Map<String, dynamic> obj) {
  return Produk(
    id: obj['id'],
    namaProduk: obj['nama_produk'],
    hargaProduk: int.parse(obj['harga_produk']),
    jumlahProduk: int.parse(obj['jumlah_produk']),
    tanggalMasuk: obj['tanggal_masuk']
  );
}
```
Penjelasan: Convert JSON dari API jadi object Produk (Komputer)

## Helpers
``api.dart``
```
Future<dynamic> post(dynamic url, dynamic data) async {
  var token = await UserInfo().getToken();
  var responseJson;
  try {
    final response = await http.post(Uri.parse(url),
        body: data,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    responseJson = _returnResponse(response);
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  return responseJson;
}
```
Penjelasan: Kirim HTTP POST dengan token otomatis, handle error koneksi

```
dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return response;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 422:
      throw InvalidInputException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error occured...');
  }
}
```
Penjelasan: Validasi status code response, throw exception jika error

``api_url.dart``
```
static const String baseUrl = 'http://10.0.2.2/api_responsi';
static const String registrasi = '$baseUrl/registrasi';
static const String login = '$baseUrl/login';
static const String listProduk = '$baseUrl/produk';
static const String createProduk = '$baseUrl/produk';

static String updateProduk(String id) {
  return '$baseUrl/produk/$id/update';
}

static String showProduk(String id) {
  return '$baseUrl/produk/$id';
}

static String deleteProduk(String id) {
  return '$baseUrl/produk/$id/delete';
}
```
Penjelasan: Centralized URL endpoint API, dynamic URL dengan parameter ID

``user_info.dart``
```
Future<void> setToken(String value) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.setString("token", value);
}

Future<String?> getToken() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString("token");
}

Future<void> logout() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
}
```
Penjelasan: Simpan/ambil token dari local storage, logout hapus semua data

## Bloc
``logic_bloc.dart``
```
static Future<Login> login({String? email, String? password}) async {
  String apiUrl = ApiUrl.login;
  var body = {"email": email, "password": password};
  var response = await Api().post(apiUrl, body);
  var jsonObj = json.decode(response.body);
  var loginResult = Login.fromJson(jsonObj);
  
  await UserInfo().setToken(loginResult.token.toString());
  await UserInfo().setUserID(loginResult.userID.toString());
  
  return loginResult;
}
```
Penjelasan: Kirim email & password ke API, simpan token & userID jika berhasil

``produk_bloc.dart``
```
static Future<List<Produk>> getProduks() async {
  String apiUrl = ApiUrl.listProduk;
  var response = await Api().get(apiUrl);
  var jsonObj = json.decode(response.body);
  List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
  List<Produk> produks = [];
  for (int i = 0; i < listProduk.length; i++) {
    produks.add(Produk.fromJson(listProduk[i]));
  }
  return produks;
}
```
Penjelasan: Get semua produk dari API, convert JSON jadi List<Produk>
```
static Future addProduk({Produk? produk}) async {
  String apiUrl = ApiUrl.createProduk;
  var body = {
    "nama_produk": produk!.namaProduk,
    "harga_produk": produk.hargaProduk.toString(),
    "jumlah_produk": produk.jumlahProduk.toString(),
    "tanggal_masuk": produk.tanggalMasuk
  };
  var response = await Api().post(apiUrl, body);
  var jsonObj = json.decode(response.body);
  return jsonObj['status'];
}
```
Penjelasan: Kirim data produk baru ke API, return true/false
```
static Future updateProduk({required Produk produk}) async {
  String apiUrl = ApiUrl.updateProduk(produk.id!);
  var body = {
    "nama_produk": produk.namaProduk,
    "harga_produk": produk.hargaProduk.toString(),
    "jumlah_produk": produk.jumlahProduk.toString(),
    "tanggal_masuk": produk.tanggalMasuk
  };
  var response = await Api().put(apiUrl, jsonEncode(body));
  var jsonObj = json.decode(response.body);
  return jsonObj['status'];
}
```
Penjelasan: Update produk by ID, kirim data baru dengan PUT method
```
static Future<bool> deleteProduk({int? id}) async {
  String apiUrl = ApiUrl.deleteProduk(id.toString());
  var response = await Api().delete(apiUrl);
  var jsonObj = json.decode(response.body);
  return jsonObj['status'];
}
```
Penjelasan: Hapus produk by ID, return true/false

## UI Pages
``login_page.dart``
```
Widget _emailTextField() {
  return TextField(
    decoration: InputDecoration(
      labelText: "Email",
      prefixIcon: Icon(Icons.email),
    ),
    keyboardType: TextInputType.emailAddress,
    controller: _emailTextboxController,
  );
}
```
Penjelasan: Input field email dengan icon dan keyboard email
```
void _submit() {
  _formKey.currentState!.save();
  setState(() {
    _isLoading = true;
  });
  LoginBloc.login(
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text
  ).then((value) async {
    await Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => const ProdukPage()));
  }, onError: (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      ));
  });
  setState(() {
    _isLoading = false;
  });
}
```
Penjelasan: Validasi form, panggil LoginBloc, navigate jika sukses, show dialog jika gagal

``produk_page.dart``
```
void getData() {
  ProdukBloc.getProduks().then((value) {
    setState(() {
      list = value;
    });
  }, onError: (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Permintaan data gagal, silahkan coba lagi",
      ));
  });
}
```
Penjelasan: Load data produk dari API, update state jika sukses, show dialog jika error
```
class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk)));
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[700],
            child: Icon(Icons.computer, color: Colors.white),
          ),
          title: Text(produk.namaProduk!),
          subtitle: Text('Rp ${produk.hargaProduk}'),
        ),
      ),
    );
  }
}
```
Penjelasan: Widget card produk, tap untuk ke detail page

``produk_form.dart``
```
bool isUpdate() {
  if (widget.produk != null) {
    _namaTextboxController.text = widget.produk!.namaProduk!;
    _hargaTextboxController.text = widget.produk!.hargaProduk.toString();
    _jumlahTextboxController.text = widget.produk!.jumlahProduk.toString();
    _tanggalMasukTextboxController.text = widget.produk!.tanggalMasuk!;
    return true;
  }
  return false;
}
```
```
void simpan() {
  setState(() {
    _isLoading = true;
  });
  Produk createProduk = Produk(id: null);
  createProduk.namaProduk = _namaTextboxController.text;
  createProduk.hargaProduk = int.parse(_hargaTextboxController.text);
  createProduk.jumlahProduk = int.parse(_jumlahTextboxController.text);
  createProduk.tanggalMasuk = _tanggalMasukTextboxController.text;
  
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
```
Penjelasan: Ambil data form, create object Produk, kirim ke API, navigate jika sukses
```
void ubah() {
  setState(() {
    _isLoading = true;
  });
  Produk updateProduk = Produk(id: widget.produk!.id!);
  updateProduk.namaProduk = _namaTextboxController.text;
  updateProduk.hargaProduk = int.parse(_hargaTextboxController.text);
  updateProduk.jumlahProduk = int.parse(_jumlahTextboxController.text);
  updateProduk.tanggalMasuk = _tanggalMasukTextboxController.text;
  
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
```
Penjelasan: Update data produk existing, kirim ke API dengan ID

``produk_detail.dart``
```
void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
            (value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProdukPage()));
            }, onError: (error) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const WarningDialog(
                description: "Hapus gagal, silahkan coba lagi",
              ));
          });
        },
      ),
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );
  showDialog(builder: (context) => alertDialog, context: context);
}
```
Penjelasan: Tampilkan dialog konfirmasi, hapus jika user klik "Ya"

## Widget
``warning_dialog.dart``
```
class WarningDialog extends StatelessWidget {
  final String? description;
  const WarningDialog({Key? key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Warning"),
      content: Text(description!),
      actions: [
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
```
Penjelasan: Dialog peringatan dengan tombol OK untuk tutup

``success_dialog.dart``
```
class SuccessDialog extends StatelessWidget {
  final String? description;
  final Widget? okClick;
  const SuccessDialog({Key? key, this.description, this.okClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sukses"),
      content: Text(description!),
    );
  }
}
```
Penjelasan: Dialog sukses, auto navigate setelah 2 detik
