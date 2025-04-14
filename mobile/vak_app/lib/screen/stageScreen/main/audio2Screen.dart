import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';
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
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
    };
  }

  Future<void> _playPause() async {
    if (widget.soal.audioPertanyaan == null) return;
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(widget.soal.audioPertanyaan!));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
     child: Column(
        children: [
          // Opsi 1 (opsi A)
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedOption = 'A';
              });
              widget.onAnswerSelected(options['A']);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 250),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: selectedOption == 'A' ? LocalColor.primary : Colors.white,
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
                height: 250,
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
                    onPressed: () {
                      print("Audio dimainkan: ${widget.soal.audioPertanyaan}");
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
                      "Pertanyaan tidak tersedia",
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
          onPressed: () async {
            setState(() {
              selectedOption = 'B';
            });
            widget.onAnswerSelected(options['B']);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 250),
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: selectedOption == 'B' ? LocalColor.primary : Colors.white,
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
              height: 250,
            ),
          ),
        ),
        ],
      ),
    );
  }
}
