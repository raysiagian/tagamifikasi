// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
// import 'package:vak_app/style/boldTextStyle.dart';
// import 'package:vak_app/style/localColor.dart';

// class ScoreBoardWidget extends StatefulWidget {
//   final int idMataPelajaran;

//   const ScoreBoardWidget({super.key, required this.idMataPelajaran});

//   @override
//   State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
// }

// class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20,),
//           Text(
//             "Selamat",
//             style: BoldTextStyle.textTheme.titleMedium!.copyWith(
//               color: LocalColor.primary,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text("Kamu telah menyelesaikan Level"),
//           const SizedBox(height: 20),
//           ClipPath(
//             clipper: HexagonalClipper(reverse: true),
//             child: Container(
//               height: 200,
//               width: 200,
//               color: Colors.orangeAccent,
//               child: Padding(padding: EdgeInsets.all(4),
//               child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Border Layer
//                 ClipPath(
//                   clipper: HexagonalClipper(reverse: true),
//                   child: Container(
//                     width: 180, // Sesuaikan ukuran
//                     height: 180,
//                   ),
//                 ),
//                 // Gambar di dalam ClipPath
//                 ClipPath(
//                   clipper: HexagonalClipper(reverse: true),
//                   child: Container(
//                     width: 180, // Sesuaikan ukuran
//                     height: 180,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/background/HiFi-Home Background.png"), // Ganti dengan path gambar
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//                         ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             height: 80,
//             width: screenWidth * 0.4,
//             decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage("assets/images/component/HiFi-Score Three Star.png"),
//               fit: BoxFit.fitWidth,
//               ),
//               color: LocalColor.transparent,
//             ),
//           ),
//           const SizedBox(height: 15),
//           Text("Keterangan Level"),
//           const SizedBox(height: 30),
//           ElevatedButton(
//              style: ElevatedButton.styleFrom(
//               backgroundColor: LocalColor.primary,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//             ),
//            onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => StageScreen(idMataPelajaran: widget.idMataPelajaran),
//                 ),
//                 (Route<dynamic> route) => false, // Clear semua screen sebelumnya
//               );
//             },

//               child: Text(
//                 "Kembali",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/services/score_service.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  final int idMataPelajaran;
  final int idLevel;

  const ScoreBoardWidget({
    super.key,
    required this.idMataPelajaran,
    required this.idLevel,
  });

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  int? totalBenar;
  String? tipeDominan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSkorAkhirLevel();
  }

  // Mengambil skor akhir dari SkorService
  Future<void> fetchSkorAkhirLevel() async {
    try {
      final response = await SkorService().fetchSkorAkhirLevel(
        idMataPelajaran: widget.idMataPelajaran,
        idLevel: widget.idLevel,
      );

      if (response['status'] == 'success') {
        final data = response['data'];
        final visual = data['total_visual'] ?? 0;
        final auditori = data['total_auditori'] ?? 0;
        final kinestetik = data['total_kinestetik'] ?? 0;

        // Total benar dihitung dari penjumlahan semua tipe
        final total = visual + auditori + kinestetik;

        // Menentukan tipe dominan
        String dominan = '-';
        final max = [visual, auditori, kinestetik].reduce((a, b) => a > b ? a : b);
        if (max == visual) dominan = "Visual";
        else if (max == auditori) dominan = "Auditori";
        else if (max == kinestetik) dominan = "Kinestetik";

        setState(() {
          totalBenar = total;
          tipeDominan = dominan;
          isLoading = false;
        });
      } else {
        throw Exception(response['message'] ?? 'Gagal memuat skor');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  // Mendapatkan gambar berdasarkan skor
  String _getImageByScore(int? score) {
    if (score == null) return 'assets/images/component/HiFi-Score Zero Star.png';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
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
                        image: AssetImage(_getImageByScore(totalBenar)),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Text(
                //   "Skor kamu: ${totalBenar ?? 0}",
                //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 5),
                Text("Tipe dominan: ${tipeDominan ?? '-'}"),
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
                        builder: (context) => StageScreen(idMataPelajaran: widget.idMataPelajaran),
                      ),
                      (Route<dynamic> route) => false, // Clear semua screen sebelumnya
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
}
