import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/localColor.dart';

class AudioScreen extends StatefulWidget {
  final Soal soal;
  const AudioScreen({Key? key, required this.soal}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isPressed = false;

  String? selectedAnswer;
  
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
      await _audioPlayer.play(AssetSource(widget.soal.audioPertanyaan!));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColor.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Listener(
              onPointerDown: (_) => setState(() => isPressed = true),
              onPointerUp: (_) => setState(() => isPressed = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform: isPressed ? Matrix4.translationValues(0, 4, 0) : Matrix4.identity(),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30),
                      backgroundColor: isPlaying ? Colors.redAccent : Colors.green,
                      shadowColor: Colors.black,
                      elevation: isPressed ? 5 : 15,
                    ),
                    onPressed: _playPause,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.soal.pertanyaan ?? "Pertanyaan tidak tersedia",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
           children: _buildAnswerButtons(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnswerButtons(BuildContext context) {
    List<String?> options = [
      widget.soal.opsiA,
      widget.soal.opsiB,
      widget.soal.opsiC,
      widget.soal.opsiD
    ];

    return options.where((option) => option != null).map((option) {
      return _buildAnswerButton(context, option!);
    }).toList();
  }

  Widget _buildAnswerButton(BuildContext context, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedAnswer = text;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedAnswer == text ? Colors.blue : Colors.white,
          foregroundColor: LocalColor.primary,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}