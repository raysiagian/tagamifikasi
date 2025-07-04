import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';

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
  if (widget.soal.media == null) return;

  if (isPlaying) {
    await _audioPlayer.pause();
  } else {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(widget.soal.media!));
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
          // Tips
          // Update selanjutnya
          // Container(
          //   width: double.infinity,
          //   height: 100,
          //   decoration: BoxDecoration(
          //     color: LocalColor.brown,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Icon(Icons.lightbulb_circle_outlined),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //              Text(
          //               "Tips",
          //               style: BoldTextStyle.textTheme.titleLarge!.copyWith(color: Colors.white)
          //             ),
          //              Text("Pilih 1 Jawaban yang benar",
          //               style: RegulerTextStyle.textTheme.titleLarge!.copyWith(color: Colors.white), 
          //               ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20,),
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
                    width: 150,
                    height: 150,
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
            const SizedBox(height: 30),
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
                    // putar audio pertanyaan
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LocalColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () async {
                      if (widget.soal.audioPertanyaan != null) {
                        await _audioPlayer.stop(); // Optional: biar nggak tabrakan kalau lagi ada audio jalan
                        await _audioPlayer.play(UrlSource(widget.soal.audioPertanyaan!));
                      } else {
                        print("Tidak ada audio untuk pertanyaan.");
                      }
                    },
                    child: Image.asset(
                      "assets/images/component/HiFi-Speaker.png",
                      width: 40,
                      height: 40,
                    ),
                  ),

                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: LocalColor.primary,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     padding: const EdgeInsets.all(16),
                    //   ),
                    //   onPressed: () {
                    //     print("Audio dimainkan: ${widget.soal.audioPertanyaan}");
                    //   },
                    //   child: Image.asset(
                    //     "assets/images/component/HiFi-Speaker.png",
                    //     width: 40,
                    //     height: 40,
                    //   ),
                    // ),
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
          // widget.onAnswerSelected(text);
          widget.onAnswerSelected(_getHurufDariOpsi(text));

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
            side: BorderSide(
              color: isSelected ? Colors.green : Colors.white, // Warna border dinamis
              width: 2, // Ketebalan border
            ),
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

  String _getHurufDariOpsi(String opsi) {
    if (opsi == widget.soal.opsiA) return "A";
    if (opsi == widget.soal.opsiB) return "B";
    if (opsi == widget.soal.opsiC) return "C";
    if (opsi == widget.soal.opsiD) return "D";
    return opsi;
  }
}

