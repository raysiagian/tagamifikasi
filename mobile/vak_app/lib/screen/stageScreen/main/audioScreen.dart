import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class AudioScreen extends StatefulWidget {
  final Soal soal;
  final void Function(String?) onAnswerSelected;

  const AudioScreen({
    Key? key,
    required this.soal,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isPressed = false;
  String? selectedOption;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Listener(
                onPointerDown: (_) => setState(() => isPressed = true),
                onPointerUp: (_) => setState(() => isPressed = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: isPressed
                      ? Matrix4.translationValues(0, 4, 0)
                      : Matrix4.identity(),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(30),
                        backgroundColor:
                            isPlaying ? Colors.redAccent : Colors.green,
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
            Container(
              width: double.infinity,
              height: 102,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 21, horizontal: 29),
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

            // Responsive 2 kolom Wrap
            LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                double spacing = 30;
                double itemWidth = (maxWidth - spacing) / 2;

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: spacing,
                  runSpacing: 10,
                  children: _buildAnswerButtons(itemWidth),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnswerButtons(double itemWidth) {
    final Map<String, String?> options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
      'C': widget.soal.opsiC,
      'D': widget.soal.opsiD,
    };

    return options.entries
        .where((entry) => entry.value != null)
        .map((entry) => _buildAnswerButton(entry.key, entry.value!, itemWidth))
        .toList();
  }

  Widget _buildAnswerButton(String label, String text, double itemWidth) {
    final bool isSelected = selectedOption == label;

    return SizedBox(
      width: itemWidth,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedOption = label;
          });
          widget.onAnswerSelected(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          foregroundColor: LocalColor.primary,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

