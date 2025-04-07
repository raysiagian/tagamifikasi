import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';
import 'package:vak_app/services/auth_services.dart';
import 'package:vak_app/services/jawaban_services.dart';
import 'package:vak_app/services/soal_services.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelScreen extends StatefulWidget {
  final Level level;
  final int idMataPelajaran;

  const LevelScreen({super.key, required this.level, required this.idMataPelajaran});

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late Future<List<Soal>> futureSoal;
  int _currentIndex = 0;
  List<Soal> _soalList = [];

  Map<int, String> jawabanSiswa = {};

  @override
  void initState() {
    // super.initState();
    // futureSoal = _fetchSoal(); // Memanggil soal berdasarkan idMataPelajaran & idLevel
    debugPrint("Level: ${widget.level.penjelasan_level}");
    futureSoal = SoalService().fetchSoalByLevel(widget.level.id_level);
  }

  Future<List<Soal>> _fetchSoal() async {
    return SoalService().fetchSoalByLevel(widget.idMataPelajaran);
  }

Future<void> submitJawaban(int idSoal, String jawaban) async {
  final token = await AuthService().getToken();

  if (token == null) {
    throw Exception("Token tidak ditemukan. Pastikan user sudah login.");
  }

  await JawabanService().kirimJawaban(
    id_soal: idSoal,
    jawaban_siswa: jawaban,
    token: token,
  );
}


  // void _nextQuestion() {
  //   if (_currentIndex < _soalList.length - 1) {
  //     setState(() {
  //       _currentIndex++;
  //     });
  //   } else {
  //     print("Jawaban siswa:");
  //     jawabanSiswa.forEach((idSoal, jawaban) {
  //       print("ID Soal: $idSoal => Jawaban: $jawaban");
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Soal selesai!")),
  //     );
  //   }
  // }

  void _nextQuestion() async {
  final soal = _soalList[_currentIndex];
  final jawaban = jawabanSiswa[soal.id_soal];

  if (jawaban != null) {
    try {
      await submitJawaban(soal.id_soal, jawaban);
      debugPrint("Jawaban dikirim untuk ID Soal: ${soal.id_soal}");
    } catch (e) {
      debugPrint("Gagal mengirim jawaban: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim jawaban untuk soal ${soal.id_soal}")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Silakan pilih jawaban terlebih dahulu")),
    );
    return; // Jangan lanjut ke soal berikutnya kalau belum dijawab
  }

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
      appBar: AppBar(title: Text(widget.level.penjelasan_level)),
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
              backgroundColor = LocalColor.redBackground;
              break;
            case 'auditory':
              backgroundColor = LocalColor.greenBackground;
              break;
            case 'kinestetik':
              backgroundColor = LocalColor.yellowBackground;
              break;
            default:
              backgroundColor = Colors.white;
          }

          return Container(
            color: backgroundColor,
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

  Widget _buildSoalScreen(Soal soal) {
    switch (soal.tipeSoal.toLowerCase()) {
     case 'visual':
        return VisualScreen(
          soal: soal,
          onAnswerSelected: (jawaban) {
            if (jawaban != null) {
              jawabanSiswa[soal.id_soal] = jawaban;
            }
          },
        );
      case 'kinestetik':
        return KinestetikScreen(soal: soal);
      case 'auditory':
       return VisualScreen(
          soal: soal,
          onAnswerSelected: (jawaban) {
            if (jawaban != null) {
              jawabanSiswa[soal.id_soal] = jawaban;
            }
          },
        );
      
      default:
        return const Center(child: Text("Tipe soal tidak dikenali"));
    }
  }
}