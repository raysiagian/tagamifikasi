// // Payment Screen

import 'dart:io';
import 'package:GamiLearn/screen/profileScreen/widget/chooseImageWidget.dart';
import 'package:GamiLearn/screen/profileScreen/widget/copyPaymenNUmberWidget.dart';
import 'package:GamiLearn/screen/profileScreen/widget/copyTotalPriceWidget.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentScreen> {
  String? _imageError;
  File? _imageFile;


  void _pembayaran(BuildContext context) async {

    bool hasError = false;
    // Validasi gambar
    if (_imageFile == null) {
      setState(() {
        _imageError = "Bukti pembayaran wajib diunggah";
      });
      hasError = true;
    } else {
      setState(() {
        _imageError = null;
      });
    }

    if (!hasError) {
      // Kirim data ke backend
      print("Gambar: ${_imageFile!.path}");

      // Tampilkan modal popup
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                const Expanded(child: Text("Pembayaran sedang diproses...")),
              ],
            ),
          );
        },
      );

      // Simulasi delay upload ke server
      await Future.delayed(const Duration(seconds: 2));

      // Tutup modal
      if (context.mounted) Navigator.of(context).pop();

      // Tampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bukti pembayaran berhasil dikirim!')),
      );

      // Reset form jika diperlukan
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Pembayaran")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                         image: AssetImage("assets/images/component/dana.png"),
                        ),
                      ),
                    ),
                    Text("Dana Indonesia", style: RegulerTextStyle.textTheme.titleMedium?.copyWith(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CopyPaymentNumberWidget(
                label: "Kirim ke",
                number: "081234567890", // Ganti ke nomor tujuan yang sebenarnya
              ),
              const SizedBox(height: 20),
              const CopyTotalPriceWidget(
                label: "Total Harga", 
                number: "16000",
              ),
              const SizedBox(height: 20),
              ChooseImageWidget(
                onImageSelected: (file) {
                  setState(() {
                    _imageFile = file;
                  });
                },
              ),
              if (_imageError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_imageError!, style: const TextStyle(color: LocalColor.red)),
                ),
              const SizedBox(height: 20),
              SizedBox(
                height: 44,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _pembayaran(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColor.greenBackground,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Kirim Bukti Pembayaran", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
