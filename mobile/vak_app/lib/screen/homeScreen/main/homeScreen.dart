// import 'package:flutter/material.dart';
// import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
// import 'package:vak_app/style/localColor.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/background/HiFi-Home Background.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height,
//                 color: LocalColor.transparent,
//               ),
//               _buildSubjectIcon(top: 290, left: 80, imagePath: "assets/images/component/HiFi-Komunikasi Subject Icon.png"),
//               _buildSubjectIcon(top: 340, right: 20, imagePath: "assets/images/component/HiFi-Bahasa Indonesia Subject Icon.png"),
//               _buildSubjectIcon(bottom: 160, left: 20, imagePath: "assets/images/component/HiFi-Bahasa Inggris Subject Icon.png"),
//               _buildSubjectIcon(bottom: 20, left: 80, imagePath: "assets/images/component/HiFi-Matematika Subject Icon.png"),
//               _buildSubjectIcon(bottom: 120, right: 50, imagePath: "assets/images/component/HiFi-Sains Subject Icon.png"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubjectIcon({double? top, double? bottom, double? left, double? right, required String imagePath}) {
//     return Positioned(
//       top: top,
//       bottom: bottom,
//       left: left,
//       right: right,
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => StageScreen()),
//           );
//         },
//         child: Container(
//           width: 70,
//           height: 70,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/services/mataPelajaran_services.dart';
import '../../../models/mataPelajaran.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MataPelajaranService _mataPelajaranService = MataPelajaranService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/background/HiFi-Home Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List<MataPelajaran>>(
            future: _mataPelajaranService.fetchMataPelajaran(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("Tidak ada data mata pelajaran"));
              }

              List<MataPelajaran> mataPelajaranList = snapshot.data!;
              List<Widget> subjectIcons = [];

              List<Map<String, dynamic>> iconPositions = [
                {"top": 290.0, "left": 80.0},
                {"top": 340.0, "right": 20.0},
                {"bottom": 160.0, "left": 20.0},
                {"bottom": 20.0, "left": 80.0},
                {"bottom": 120.0, "right": 50.0},
              ];

              for (int i = 0; i < mataPelajaranList.length; i++) {
                MataPelajaran mataPelajaran = mataPelajaranList[i];
                subjectIcons.add(
                  _buildSubjectIcon(
                    top: iconPositions[i]["top"],
                    bottom: iconPositions[i]["bottom"],
                    left: iconPositions[i]["left"],
                    right: iconPositions[i]["right"],
                    imagePath: mataPelajaran.iconPath,
                  ),
                );
              }

              return Stack(children: subjectIcons);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectIcon(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      required String imagePath}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StageScreen()),
          );
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
