// // import 'package:flutter/material.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
// // import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
// // import 'package:vak_app/screen/stageScreen/main/kinestetikScreen2.dart';
// // import 'package:vak_app/screen/stageScreen/main/kinestetikScreen3t.dart';
// // import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';

// // class UnitWidget extends StatelessWidget {
// //   const UnitWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double iconSize = 70; // Ukuran ikon
// //     double spacing = 70; // Jarak antar ikon vertikal
// //     double zigzagOffset = 80; // Lebar zig-zag (jarak horizontal)

// //     // Tolong ganti code sesuai kondisi

// //     List<Widget> pages = [

// //     ];

// //     return Column(
// //       children: [
// //         // Container dengan teks "Unit Name"
// //         // Container(
// //         //   width: double.infinity,
// //         //   height: 60.0,
// //         //   decoration: BoxDecoration(
// //         //     borderRadius: BorderRadius.circular(10),
// //         //     color: Colors.white,
// //         //   ),
// //         //   padding: const EdgeInsets.symmetric(horizontal: 8),
// //         //   alignment: Alignment.centerLeft,
// //         //   child: const Text("Unit Name"),
// //         // ),

// //         // const SizedBox(height: 15), // Jarak antara unit name dan ikon

// //         // Stack untuk menumpuk ikon
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10),
// //           child: Stack(
// //             children: [
// //               // Background utama
// //               Container(
// //                 width: double.infinity,
// //                 height: 500, // Tinggi area Stack
// //                 color: Colors.transparent,
// //               ),

// //               // Menggunakan List.generate untuk efek ular (zig-zag 2 langkah)
// //               ...List.generate(6, (index) {
// //                 double topPosition = 20 + (index * spacing); // Jarak antar ikon
// //                 double baseOffset =
// //                     (screenWidth - iconSize) / 2; // Posisi tengah container

// //                 // Pola zig-zag hanya 2 langkah: kanan & kiri bergantian
// //                 double horizontalOffset = baseOffset +
// //                     ((index % 2 == 0) ? zigzagOffset : -zigzagOffset);

// //                 return Positioned(
// //                   left: horizontalOffset,
// //                   top: topPosition,
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => pages[index]),
// //                       );
// //                     },
// //                     child: Image.asset(
// //                       "assets/images/component/LoFi-Level Icon.png",
// //                       width: iconSize,
// //                       height: iconSize,
// //                     ),
// //                   ),
// //                 );
// //               }),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // contoh penerapan kode

// // class Page4 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Halaman 4")),
// //       body: Center(child: Text("Ini adalah halaman 4")),
// //     );
// //   }
// // }

// // class Page5 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Halaman 5")),
// //       body: Center(child: Text("Ini adalah halaman 5")),
// //     );
// //   }
// // }

// // class Page6 extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Halaman 6")),
// //       body: Center(child: Text("Ini adalah halaman 6")),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:vak_app/models/level.dart';
// import 'package:vak_app/screen/stageScreen/main/levelScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:vak_app/models/level.dart';
// import 'package:vak_app/screen/stageScreen/main/levelScreen.dart';

// class UnitWidget extends StatelessWidget {
//   const UnitWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double iconSize = 70; // Ukuran ikon
//     double spacing = 70; // Jarak antar ikon vertikal
//     double zigzagOffset = 80; // Lebar zig-zag (jarak horizontal)

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: level.length * spacing + 50, // Sesuaikan tinggi dengan jumlah level
//             color: Colors.transparent,
//           ),
//           ...level.asMap().entries.map((entry) {
//             int index = entry.key;
//             Level currentLevel = entry.value;

//             double topPosition = 20 + (index * spacing);
//             double baseOffset = (screenWidth - iconSize) / 2;
//             double horizontalOffset = baseOffset + ((index % 2 == 0) ? zigzagOffset : -zigzagOffset);

//             return Positioned(
//               left: horizontalOffset,
//               top: topPosition,
//               child: GestureDetector(
//                 onTap: () {
//                   // Navigasi ke LevelScreen dengan objek Level yang benar
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LevelScreen(level: currentLevel),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/component/LoFi-Level Icon.png",
//                       width: iconSize,
//                       height: iconSize,
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "Level ${currentLevel.id_level}",
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/screen/stageScreen/main/levelScreen.dart';

class UnitWidget extends StatelessWidget {
  const UnitWidget({super.key});

 void _showLevelBottomSheet(BuildContext context, Level level, int index) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Mengizinkan bottom sheet memenuhi layar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width, // Paksa lebar penuh
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Level ${index + 1}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(level.penjelasan_level),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelScreen(level: level),
                  ),
                );
              },
              child: Text("Mulai Level"),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = 70; // Ukuran ikon
    double spacing = 70; // Jarak antar ikon vertikal
    double zigzagOffset = 80; // Lebar zig-zag (jarak horizontal)

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: level.length * spacing + 50, // Sesuaikan tinggi dengan jumlah level
            color: Colors.transparent,
          ),
          ...level.asMap().entries.map((entry) {
            int index = entry.key;
            Level currentLevel = entry.value;

            double topPosition = 20 + (index * spacing);
            double baseOffset = (screenWidth - iconSize) / 2;
            double horizontalOffset = baseOffset + ((index % 2 == 0) ? zigzagOffset : -zigzagOffset);

            return Positioned(
              left: horizontalOffset,
              top: topPosition,
              child: GestureDetector(
                onTap: () => _showLevelBottomSheet(context, currentLevel, index),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/component/LoFi-Level Icon.png",
                      width: iconSize,
                      height: iconSize,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Level ${currentLevel.id_level}",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
