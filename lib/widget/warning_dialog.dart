import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String? description;
  const WarningDialog({Key? key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange[700], size: 28),
          const SizedBox(width: 12),
          const Text("Peringatan", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: Text(description!, style: const TextStyle(fontSize: 16)),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
