import 'package:flutter/material.dart';
import 'package:vak_app/models/level.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/screen/stageScreen/main/afterLevelScreen.dart';
import 'package:vak_app/screen/stageScreen/main/audio2Screen.dart';
import 'package:vak_app/screen/stageScreen/main/audioScreen.dart';
import 'package:vak_app/screen/stageScreen/main/kinestetik2Screen.dart';
import 'package:vak_app/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:vak_app/screen/stageScreen/main/visual2Screen.dart';
import 'package:vak_app/screen/stageScreen/main/visualScreen.dart';
import 'package:vak_app/screen/unknownScreen/widget/customErrorWidget.dart';
import 'package:vak_app/screen/unknownScreen/widget/noQuestionWidget.dart';
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

   Future<void> _simpanProgressIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'progress_${widget.level.id_level}';
    await prefs.setInt(key, index);
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

  void _nextQuestion() async {
  final soal = _soalList[_currentIndex];
  final jawaban = jawabanSiswa[soal.id_soal];

  if (jawaban != null) {
    try {
      await submitJawaban(soal.id_soal, jawaban);
      debugPrint("Jawaban dikirim :$jawaban, id soal: ${soal.id_soal}");
      print(jawaban);
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
  Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => AfterLevelScreen(idMataPelajaran: widget.idMataPelajaran, idLevel: widget.level.id_level,),
  ),
);

  }
}

 void _prevQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
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
          }else if (snapshot.hasError) {
            return Center(child: CustomErrorWidget(),); 
          }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: NoQuestionWidget());
          }

          _soalList = snapshot.data!;
          final soal = _soalList[_currentIndex];

          // Tentukan warna background berdasarkan tipe soal
          Color backgroundColor;
          switch (soal.tipeSoal.toLowerCase()) {
            case 'visual1':
              backgroundColor = LocalColor.redBackground;
              break;
            case 'visual2':
              backgroundColor = LocalColor.redBackground;
              break;
            // case 'visual2':
            //   backgroundColor = LocalColor.redBackground;
            //   break;
            case 'auditori1':
              backgroundColor = LocalColor.greenBackground;
              break;
            case 'auditori2':
              backgroundColor = LocalColor.greenBackground;
              break;
            // case 'auditory2':
            //   backgroundColor = LocalColor.greenBackground;
            //   break;
            case 'kinestetik1':
              backgroundColor = LocalColor.yellowBackground;
              break;
            case 'kinestetik2':
              backgroundColor = LocalColor.yellowBackground;
              break;
            default:
              backgroundColor = Colors.white;
          }

          return Container(
            color: backgroundColor,
            child: Column(
              children: [
                 const SizedBox(height: 16),
                Text(
                  'Soal ke ${_currentIndex + 1} dari ${_soalList.length}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildSoalScreen(soal)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       if (_currentIndex > 0)
                        ElevatedButton(
                          onPressed: _prevQuestion,
                          child: const Text("Kembali"),
                        )
                      else
                        const SizedBox(width: 100), // Placeholder biar sejajar
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        child: const Text("Selanjutnya"),
                      ),
                    ],
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
     case 'visual1':
        return VisualScreen(
          soal: soal,
          onAnswerSelected: (jawaban) {
            if (jawaban != null) {
              jawabanSiswa[soal.id_soal] = jawaban;
            }
          },
        );
      case 'visual2':
        return Visual2Screen(
          soal: soal,
          onAnswerSelected: (jawaban) {
            if (jawaban != null) {
              jawabanSiswa[soal.id_soal] = jawaban;
            }
          },
        );
      // case 'kinestetik1':
      //   return KinestetikScreen(soal: soal);
      case 'kinestetik1':
        return KinestetikScreen(
          soal: soal,
          onJawabanSelesai: (jawaban) {
            jawabanSiswa[soal.id_soal] = jawaban;
            print("Jawaban kinestetik1: $jawaban");
          },
        );

      case 'kinestetik2':
        return Kinestetik2Screen(
          soal: soal,
          onJawabanSelesai: (jawaban) {
            jawabanSiswa[soal.id_soal] = jawaban;
            print("Jawaban kinestetik2: $jawaban");
          },
        );
      case 'auditori1':
       return AudioScreen(
          soal: soal,
          onAnswerSelected: (jawaban) {
            if (jawaban != null) {
              jawabanSiswa[soal.id_soal] = jawaban;
            }
            },
          );
      case 'auditori2':
       return Audio2Screen(
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