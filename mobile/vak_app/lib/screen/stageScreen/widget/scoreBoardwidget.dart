import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/services/score_service.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  final int idMataPelajaran;
  final int idLevel;

  const ScoreBoardWidget({
    Key? key,
    required this.idMataPelajaran,
    required this.idLevel,
  }) : super(key: key);

  @override
  _ScoreBoardWidgetState createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  int jumlahBenar = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchJumlahBenar();
  }

  Future<void> _fetchJumlahBenar() async {
    try {
      final result = await SkorService().fetchJumlahBenarTerbaru(
        widget.idMataPelajaran, 
        widget.idLevel,
      );
      setState(() {
        jumlahBenar = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: LocalColor.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Kamu telah menyelesaikan level ini!"),
                const SizedBox(height: 20),
                ClipPath(
                  clipper: HexagonalClipper(reverse: true),
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          _getImageByScore(jumlahBenar),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Jumlah benar: $jumlahBenar",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LocalColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StageScreen(idMataPelajaran: widget.idMataPelajaran),
                      ),
                      (Route<dynamic> route) => false,
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

  String _getImageByScore(int score) {
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
}