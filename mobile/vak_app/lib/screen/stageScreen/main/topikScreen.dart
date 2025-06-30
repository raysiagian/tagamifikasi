import 'package:GamiLearn/models/topik.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/screen/stageScreen/main/afterLevelScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/audio2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/audioScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/kinestetik2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/kinestetikScreen.dart';
import 'package:GamiLearn/screen/stageScreen/main/visual2Screen.dart';
import 'package:GamiLearn/screen/stageScreen/main/visualScreen.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/customErrorWidget.dart';
import 'package:GamiLearn/screen/unknownScreen/widget/noQuestionWidget.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/services/jawaban_services.dart';
import 'package:GamiLearn/services/soal_services.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopikScreen extends StatefulWidget {
  final Topik topik;

  const TopikScreen({super.key, required this.topik,});

  @override
  _TopikScreenState createState() => _TopikScreenState();
}

class _TopikScreenState extends State<TopikScreen> {
  late Future<List<Soal>> futureSoal;
  int _currentIndex = 0;
  List<Soal> _soalList = [];

  Map<int, String> jawabanSiswa = {};

  @override
  void initState() {
    debugPrint("Topik: ${widget.topik.nama_topik}");
    futureSoal = SoalService().fetchSoalByTopik(widget.topik.id_topik);
  }

  Future<List<Soal>> _fetchSoal() async {
    return SoalService().fetchSoalByTopik(widget.topik.id_topik);
  }

  Future<void> _simpanProgressIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'progress_${widget.topik.id_topik}';
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
      return;
    }

    if (_currentIndex < _soalList.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AfterLevelScreen(topik: widget.topik,),
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

  // Method to get background image based on question type
  String _getBackgroundImage(String tipeSoal) {
    switch (tipeSoal.toLowerCase()) {
      case 'visual1':
      case 'visual2':
        return 'assets/images/background/HiFi-After Level Background.png'; // Replace with your image path
      case 'auditori1':
      case 'auditori2':
        return 'assets/images/background/HiFi-After Level Background.png'; // Replace with your image path
      case 'kinestetik1':
      case 'kinestetik2':
        return 'assets/images/background/HiFi-After Level Background.png'; // Replace with your image path
      default:
        return 'assets/images/background/HiFi-After Level Background.png'; // Replace with your default image path
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topik.nama_topik)),
      body: FutureBuilder<List<Soal>>(
        future: futureSoal,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: CustomErrorWidget(),); 
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: NoQuestionWidget());
          }

          _soalList = snapshot.data!;
          final soal = _soalList[_currentIndex];

          return Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_getBackgroundImage(soal.tipeSoal)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Soal ke ${_currentIndex + 1} dari ${_soalList.length}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Adjust text color for visibility
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: _buildSoalScreen(soal),
                    ),
                  ),
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
                          const SizedBox(width: 100),
                        ElevatedButton(
                          onPressed: _nextQuestion,
                          child: const Text("Selanjutnya"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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