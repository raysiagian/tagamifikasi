import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio2Screen extends StatefulWidget {
  final Soal soal;
  final void Function(String?) onAnswerSelected;

  const Audio2Screen({
    Key? key,
    required this.soal,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<Audio2Screen> createState() => _Audio2ScreenState();
}

class _Audio2ScreenState extends State<Audio2Screen> {
  String? selectedOption;
  late Map<String, String?> options;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? _currentlyPlayingUrl;

  @override
  void initState() {
    super.initState();
    options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
    };
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> _playPause(String option) async {
  String? audioToPlay;

  if (option == 'A') {
    audioToPlay = widget.soal.opsiA;
  } else if (option == 'B') {
    audioToPlay = widget.soal.opsiB;
  } else {
    audioToPlay = widget.soal.audioPertanyaan;
  }

  if (audioToPlay == null || audioToPlay.isEmpty) {
    print("URL audio kosong atau null");
    return;
  }

  print("Audio yang akan diputar: $audioToPlay");

  if (_currentlyPlayingUrl == audioToPlay && isPlaying) {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  } else {
    await _audioPlayer.stop();
    await _audioPlayer.setSource(UrlSource(audioToPlay));
    await _audioPlayer.resume(); // Hanya ini cukup
    setState(() {
      isPlaying = true;
      _currentlyPlayingUrl = audioToPlay;
    });
  }
}

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColor.transparent,
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Tombol opsi A
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedOption = 'A';
                });
                  widget.onAnswerSelected('A');
                _playPause('A');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: selectedOption == 'A' ? Colors.green : Colors.transparent,
                  width: 3,
                ),
              ),
              child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
            ),
          ),

          const SizedBox(height: 20),

          // Tombol play untuk pertanyaan
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
                    onPressed: () {
                      print("Audio pertanyaan dimainkan: ${widget.soal.audioPertanyaan}");
                      _playPause('Q'); // 'Q' untuk pertanyaan
                    },
                    child: Image.asset(
                      "assets/images/component/HiFi-Speaker.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 21),
                  Expanded(
                    child: Text(
                      widget.soal.pertanyaan ?? "Putar Pertanyaan",
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

          // Tombol opsi B
          SizedBox(
             width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedOption = 'B';
                });
                  widget.onAnswerSelected('B');
                _playPause('B');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(150, 150),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: selectedOption == 'B' ? Colors.green : Colors.transparent,
                  width: 3,
                ),
              ),
              child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
            ),
          ),
        ],
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
