import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String? description;
  final VoidCallback? okClick;

  const SuccessDialog({Key? key, this.description, this.okClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green[600], size: 28),
          const SizedBox(width: 12),
          const Text("Sukses", style: TextStyle(fontWeight: FontWeight.bold)),
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
            if (okClick != null) {
              okClick!();
            }
          },
        ),
      ],
    );
  }
}
