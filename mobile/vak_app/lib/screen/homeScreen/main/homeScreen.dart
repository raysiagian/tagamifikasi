import 'package:flutter/material.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/customerrorWidget.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/noSubjectWidget.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/style/localColor.dart';

import '../../../models/mataPelajaran.dart';
import '../../../services/matapelajaran_Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MataPelajaranService _mataPelajaranService = MataPelajaranService();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background/HiFi-Home Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List<MataPelajaran>>(
            future: _mataPelajaranService.fetchMataPelajaran(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: CustomErrorWidget());
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: NoSubjectWidget());
              }

              // Filter agar Bahasa Inggris tidak tampil
              List<MataPelajaran> mataPelajaranList = snapshot.data!
                  .where((e) => e.nama != "English")
                  .toList();
              List<Widget> subjectIcons = [];

              // Gunakan persentase layar untuk posisi agar responsif
              List<Map<String, double?>> iconPositions = [
                {"top": screenHeight * 0.30, "left": screenWidth * 0.20},
                {"top": screenHeight * 0.40, "right": screenWidth * 0.05},
                {"bottom": screenHeight * 0.25, "left": screenWidth * 0.05},
                {"bottom": screenHeight * 0.08, "left": screenWidth * 0.20},
                {"bottom": screenHeight * 0.18, "right": screenWidth * 0.10},
              ];

              for (int i = 0; i < mataPelajaranList.length; i++) {
                MataPelajaran mataPelajaran = mataPelajaranList[i];
                var position = iconPositions[i];

                // Debug info
                print("Mata Pelajaran: ${mataPelajaran.nama}");
                print("Icon Path: ${mataPelajaran.iconPath}");
                print(
                    "Posisi => top: ${position["top"]}, bottom: ${position["bottom"]}, left: ${position["left"]}, right: ${position["right"]}");

                subjectIcons.add(
                  _buildSubjectIcon(
                    top: position["top"],
                    bottom: position["bottom"],
                    left: position["left"],
                    right: position["right"],
                    imagePath: mataPelajaran.iconPath,
                    idMataPelajaran: mataPelajaran.id,
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

  Widget _buildSubjectIcon({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required String imagePath,
    required int idMataPelajaran,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StageScreen(idMataPelajaran: idMataPelajaran),
            ),
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
