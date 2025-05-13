import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyPaymentNumberWidget extends StatelessWidget {
  final String label;
  final String number;

  const CopyPaymentNumberWidget({
    super.key,
    required this.label,
    required this.number,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nomor disalin: $number')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(number, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _copyToClipboard(context),
            icon: const Icon(Icons.copy, color: Colors.blue),
            tooltip: 'Salin',
          ),
        ],
      ),
    );
  }
}
