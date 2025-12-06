import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestApiPage extends StatefulWidget {
  const TestApiPage({Key? key}) : super(key: key);

  @override
  _TestApiPageState createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  String result = 'Belum ada test';
  bool isLoading = false;

  Future<void> testConnection() async {
    setState(() {
      isLoading = true;
      result = 'Testing...';
    });

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2/toko_api/'),
      ).timeout(const Duration(seconds: 5));

      setState(() {
        isLoading = false;
        if (response.statusCode == 200) {
          result = 'SUCCESS! ✅\n\n${response.body}';
        } else {
          result = 'ERROR! ❌\nStatus: ${response.statusCode}\n\n${response.body}';
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        result = 'ERROR! ❌\n\n$e\n\nPastikan:\n1. Laragon running\n2. API di C:\\laragon\\www\\toko_api\n3. Gunakan IP yang benar';
      });
    }
  }

  Future<void> testGetProduk() async {
    setState(() {
      isLoading = true;
      result = 'Testing Get Produk...';
    });

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2/toko_api/produk'),
      ).timeout(const Duration(seconds: 5));

      setState(() {
        isLoading = false;
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          result = 'SUCCESS! ✅\n\nData Produk:\n${json.encode(data, toEncodable: (e) => e.toString())}';
        } else {
          result = 'ERROR! ❌\nStatus: ${response.statusCode}';
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        result = 'ERROR! ❌\n\n$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test API Connection'),
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                padding: const EdgeInsets.all(16),
              ),
              onPressed: isLoading ? null : testConnection,
              child: const Text(
                'Test Connection',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                padding: const EdgeInsets.all(16),
              ),
              onPressed: isLoading ? null : testGetProduk,
              child: const Text(
                'Test Get Produk',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catatan:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('• Emulator Android: http://10.0.2.2/toko_api'),
                  Text('• Device Fisik: http://192.168.X.X/toko_api'),
                  Text('• Pastikan Laragon running'),
                  Text('• Pastikan database sudah di-import'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
