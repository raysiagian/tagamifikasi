import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/screen/stageScreen/main/levelScreen.dart';

import '../../../services/level_services.dart'; // Import LevelService

class UnitWidget extends StatefulWidget {
  final int idMataPelajaran; // ID mata pelajaran dari API

  const UnitWidget({super.key, required this.idMataPelajaran});

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  late Future<List<Level>>
      futureLevels; // Future untuk menyimpan level dari API

  @override
  void initState() {
    super.initState();
    futureLevels =
        LevelService().fetchLevelsByMataPelajaran(widget.idMataPelajaran);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = 70; // Ukuran ikon
    double spacing = 70; // Jarak antar ikon vertikal
    double zigzagOffset = 80; // Lebar zig-zag (jarak horizontal)

    return FutureBuilder<List<Level>>(
      future: futureLevels,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Tampilkan loading
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error: ${snapshot.error}")); // Tampilkan error
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text("Tidak ada level tersedia")); // Jika data kosong
        }

        List<Level> levels = snapshot.data!; // Ambil data dari API

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: levels.length * spacing +
                    50, // Sesuaikan tinggi dengan jumlah level
                color: Colors.transparent,
              ),
              ...levels.asMap().entries.map((entry) {
                int index = entry.key;
                Level currentLevel = entry.value;

                double topPosition = 20 + (index * spacing);
                double baseOffset = (screenWidth - iconSize) / 2;
                double horizontalOffset = baseOffset +
                    ((index % 2 == 0) ? zigzagOffset : -zigzagOffset);

                return Positioned(
                  left: horizontalOffset,
                  top: topPosition,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LevelScreen(level: currentLevel),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/component/LoFi-Level Icon.png",
                          width: iconSize,
                          height: iconSize,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          currentLevel
                              .penjelasanLevel, // Ganti dengan penjelasanLevel
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
