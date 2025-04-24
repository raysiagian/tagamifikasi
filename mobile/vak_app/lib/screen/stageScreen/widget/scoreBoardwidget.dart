import 'dart:convert';import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/services/score_service.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class ScoreBoardWidget extends StatelessWidget {
  final int idMataPelajaran;
  final int idLevel;

  const ScoreBoardWidget({
    super.key,
    required this.idMataPelajaran,
    required this.idLevel,
  });

  // Mendapatkan data skor menggunakan FutureBuilder
  Future<Map<String, dynamic>> fetchSkorAkhirLevel() {
    return SkorService().fetchSkorAkhirLevel(
      idMataPelajaran: idMataPelajaran,
      idLevel: idLevel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchSkorAkhirLevel(),  // Mendapatkan skor dari service
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Skor tidak tersedia'));
        } else {
          // Ambil data dari response
          final data = snapshot.data!['data'];
          final visual = data['total_visual'] ?? 0;
          final auditori = data['total_auditori'] ?? 0;
          final kinestetik = data['total_kinestetik'] ?? 0;

          // Hitung total skor
          final total = visual + auditori + kinestetik;

          // Menentukan tipe dominan
          String dominan = '-';
          final max = [visual, auditori, kinestetik].reduce((a, b) => a > b ? a : b);
          if (max == visual) dominan = "Visual";
          else if (max == auditori) dominan = "Auditori";
          else if (max == kinestetik) dominan = "Kinestetik";

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Selamat",
                  style: BoldTextStyle.textTheme.titleMedium!.copyWith(
                    color: LocalColor.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Kamu telah menyelesaikan Level"),
                const SizedBox(height: 20),
                ClipPath(
                  clipper: HexagonalClipper(reverse: true),
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _getImageByScore(total),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Skor kamu: $total",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text("Tipe dominan: $dominan"),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StageScreen(idMataPelajaran: idMataPelajaran),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "Kembali",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Mendapatkan gambar berdasarkan skor
  String _getImageByScore(int score) {
    if (score == 0) {
      return 'assets/images/component/HiFi-Score Zero Star.png';
    } else if (score <= 3) {
      return 'assets/images/component/HiFi-Score One Star.png';
    } else if (score <= 8) {
      return 'assets/images/component/HiFi-Score Two Star.png';
    } else {
      return 'assets/images/component/HiFi-Score Three Star.png';
    }
  }
}
