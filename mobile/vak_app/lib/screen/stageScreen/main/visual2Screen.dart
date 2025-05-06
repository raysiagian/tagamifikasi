import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:audioplayers/audioplayers.dart';

class Visual2Screen extends StatefulWidget {
  final Soal soal;
  final void Function(String?) onAnswerSelected;

  const Visual2Screen({
    Key? key,
    required this.soal,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<Visual2Screen> createState() => _Visual2ScreenState();
}

class _Visual2ScreenState extends State<Visual2Screen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? selectedOption;
  late Map<String, String?> options;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
    };
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (widget.soal.audioPertanyaan == null) return;
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(widget.soal.audioPertanyaan!));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColor.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Opsi 1 (opsi A)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'A';
                  });
                  widget.onAnswerSelected('A');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 190),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: selectedOption == 'A' ? Colors.green : Colors.transparent,
                    width: 3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    options['A'] ?? 
                        "https://res.cloudinary.com/dio9zvrg3/image/upload/v1744163521/soal/media/ptcadvfrwpmpuza3uky4.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 190,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Audio dan pertanyaan
              Container(
                width: double.infinity,
                height: 102,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LocalColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: _playPause,
                        child: Image.asset(
                          "assets/images/component/HiFi-Speaker.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 21),
                      Expanded(
                        child: Text(
                          widget.soal.pertanyaan ?? "Pertanyaan tidak tersedia",
                          style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                            color: LocalColor.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Opsi 2 (opsi B)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = 'B';
                  });
                  widget.onAnswerSelected('B'); // Mengirimkan huruf 'B'
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 190),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: selectedOption == 'B' ? Colors.green : Colors.transparent,
                    width: 3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    options['B'] ?? 
                        "https://res.cloudinary.com/dio9zvrg3/image/upload/v1744163521/soal/media/ptcadvfrwpmpuza3uky4.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 190,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getHurufDariOpsi(String opsi) {
    if (opsi == widget.soal.opsiA) return "A";
    if (opsi == widget.soal.opsiB) return "B";
    return opsi;
  }
}
