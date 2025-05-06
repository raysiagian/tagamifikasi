import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/models/soal.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:audioplayers/audioplayers.dart';

class VisualScreen extends StatefulWidget {
  final Soal soal;
  final void Function(String?) onAnswerSelected;

  const VisualScreen({
    Key? key,
    required this.soal,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? selectedOption;
  bool isPlaying = false;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Tips
          // Update Selanjutnya
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
          // Gambar dari soal
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.soal.media ?? 
                  "https://res.cloudinary.com/dio9zvrg3/image/upload/v1744163521/soal/media/ptcadvfrwpmpuza3uky4.png"), // Fallback gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Kotak pertanyaan
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

          // Opsi jawaban 2 kolom responsif
          LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;
              double spacing = 10;
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
          widget.onAnswerSelected(label);  // Kirim huruf (A, B, C, D)
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:Colors.white,
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


  // mengurimkan Huruf pada database
  String _getHurufDariOpsi(String opsi) {
    if (opsi == widget.soal.opsiA) return "A";
    if (opsi == widget.soal.opsiB) return "B";
    if (opsi == widget.soal.opsiC) return "C";
    if (opsi == widget.soal.opsiD) return "D";
    return opsi;
  }
}


