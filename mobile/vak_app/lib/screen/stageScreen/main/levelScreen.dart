import 'dart:core';
import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';
import 'package:vak_app/services/soal_services.dart';
import 'package:vak_app/style/localColor.dart';

class LevelScreen extends StatefulWidget {
  final Level level;

  const LevelScreen({Key? key, required this.level}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late Future<List<Soal>> futureSoal;
  int _currentIndex = 0;
  List<Soal> _soalList = [];

  @override
  void initState() {
    super.initState();
    debugPrint("Level:  ${widget.level.penjelasanLevel}");
    futureSoal = SoalService().fetchSoalByLevel(widget.level.idLevel);
  }

  void _nextQuestion() {
    if (_currentIndex < _soalList.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Soal selesai!")),
      );
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Level   ${widget.level.penjelasanLevel}",
        ),
      ),
      body: FutureBuilder<List<Soal>>(
        future: futureSoal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada soal untuk level ini"));
          }

        _soalList = snapshot.data!;
        final soal = _soalList[_currentIndex];

        // Tentukan warna background berdasarkan tipe soal
        Color backgroundColor;
        switch (soal.tipeSoal.toLowerCase()) {
          case 'visual':
            backgroundColor = LocalColor.redBackground; // Atau Colors.red
            break;
          case 'auditory':
            backgroundColor = LocalColor.greenBackground; // Contoh warna lain
            break;
          case 'kinestetik':
            backgroundColor = LocalColor.yellowBackground; // Contoh warna lain
            break;
          default:
            backgroundColor = Colors.white;
        }

        return Container(
          color: backgroundColor, // Terapkan warna background
          child: Column(
            children: [
              Expanded(child: _buildSoalScreen(soal)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  child: const Text("Selanjutnya"),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Level ${widget.level.id_level} - ${widget.level.penjelasan_level}")),
//       body: FutureBuilder<List<Soal>>(
//         future: futureSoal,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Tidak ada soal untuk level ini"));
//           }

//           _soalList = snapshot.data!;
//           final soal = _soalList[_currentIndex];

//           return Column(
//             children: [
//               Expanded(child: _buildSoalScreen(soal)),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: _nextQuestion,
//                   child: Text("Selanjutnya"),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

  Widget _buildSoalScreen(Soal soal) {
    switch (soal.tipeSoal.toLowerCase()) {
      case 'kinestetik':
        return KinestetikScreen(soal: soal);
      case 'auditory':
        return AudioScreen(soal: soal);
      case 'visual':
        return VisualScreen(soal: soal);
      default:
        return const Center(child: Text("Tipe soal tidak dikenali"));
    }
  }
}
