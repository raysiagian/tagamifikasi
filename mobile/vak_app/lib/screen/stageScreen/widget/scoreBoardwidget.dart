import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/services/score_service.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';

class ScoreBoardWidget extends StatelessWidget {
  final int idMataPelajaran;
  final int idLevel;

  const ScoreBoardWidget({
    super.key,
    required this.idMataPelajaran,
    required this.idLevel,
  });

  // Mendapatkan data skor menggunakan FutureBuilder
  Future<Map<String, dynamic>> fetchSkorTerbaru() {
    return SkorService().fetchSkorTerbaru(
  );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchSkorTerbaru(),  // Mendapatkan skor dari service
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

          // Ambil jumlah benar
          final jumlahBenar = data['jumlah_benar'] ?? 0;

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
                          _getImageByScore(jumlahBenar),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Tampilkan jumlah benar
                Text(
                  "Jumlah benar: $jumlahBenar",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
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

