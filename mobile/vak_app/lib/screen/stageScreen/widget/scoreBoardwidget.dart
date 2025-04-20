import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  final int idMataPelajaran;

  const ScoreBoardWidget({super.key, required this.idMataPelajaran});

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
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
              height: 200,
              width: 200,
              color: Colors.orangeAccent,
              child: Padding(padding: EdgeInsets.all(4),
              child: Stack(
              alignment: Alignment.center,
              children: [
                // Border Layer
                ClipPath(
                  clipper: HexagonalClipper(reverse: true),
                  child: Container(
                    width: 180, // Sesuaikan ukuran
                    height: 180,
                  ),
                ),
                // Gambar di dalam ClipPath
                ClipPath(
                  clipper: HexagonalClipper(reverse: true),
                  child: Container(
                    width: 180, // Sesuaikan ukuran
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background/HiFi-Home Background.png"), // Ganti dengan path gambar
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
                        ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 80,
            width: screenWidth * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/component/HiFi-Score Three Star.png"),
              fit: BoxFit.fitWidth,
              ),
              color: LocalColor.transparent,
            ),
          ),
          const SizedBox(height: 15),
          Text("Keterangan Level"),
          const SizedBox(height: 30),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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

              child: Text(
                "Kembali",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// final screenWidth = MediaQuery.of(context).size.width;
// padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),


// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
// import 'package:vak_app/services/score_service.dart';
// import 'package:vak_app/style/boldTextStyle.dart';
// import 'package:vak_app/style/localColor.dart';

// class ScoreBoardWidget extends StatefulWidget {
//   final int idMataPelajaran;

//   const ScoreBoardWidget({super.key, required this.idMataPelajaran});

//   @override
//   State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
// }

// class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
//   Map<String, dynamic>? skorData;
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     loadSkor();
//   }

//   Future<void> loadSkor() async {
//     try {
//       final skor = await SkorService().fetchSkorAkhir(widget.idMataPelajaran);
//       setState(() {
//         skorData = skor;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (errorMessage != null) {
//       return Center(child: Text("Error: $errorMessage"));
//     }

//     final skor = skorData?['skor'] ?? 0;
//     final status = skorData?['status'] ?? 'Belum diketahui';

//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20),
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
//               child: Padding(
//                 padding: const EdgeInsets.all(4),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     ClipPath(
//                       clipper: HexagonalClipper(reverse: true),
//                       child: Container(
//                         width: 180,
//                         height: 180,
//                       ),
//                     ),
//                     ClipPath(
//                       clipper: HexagonalClipper(reverse: true),
//                       child: Container(
//                         width: 180,
//                         height: 180,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/background/HiFi-Home Background.png"),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           Container(
//             height: 80,
//             width: screenWidth * 0.4,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/component/HiFi-Score Three Star.png"),
//                 fit: BoxFit.fitWidth,
//               ),
//               color: LocalColor.transparent,
//             ),
//           ),

//           const SizedBox(height: 15),

//           Text("Skor Akhir: $skor"),
//           Text("Status: $status"),

//           const SizedBox(height: 30),

//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: LocalColor.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//             ),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       StageScreen(idMataPelajaran: widget.idMataPelajaran),
//                 ),
//                 (Route<dynamic> route) => false,
//               );
//             },
//             child: const Text(
//               "Kembali",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
