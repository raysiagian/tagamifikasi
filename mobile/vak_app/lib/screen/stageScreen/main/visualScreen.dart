import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

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
  String? selectedOption; // 'A', 'B', 'C', 'D'

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Gambar dari soal
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.soal.media ??
                    "https://via.placeholder.com/300"), // Fallback gambar
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

          // Opsi jawaban
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: _buildAnswerButtons(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnswerButtons() {
    final Map<String, String?> options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
      'C': widget.soal.opsiC,
      'D': widget.soal.opsiD,
    };

    return options.entries
        .where((entry) => entry.value != null)
        .map((entry) => _buildAnswerButton(entry.key, entry.value!))
        .toList();
  }

  Widget _buildAnswerButton(String label, String text) {
    final bool isSelected = selectedOption == label;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedOption = label;
          });
          widget.onAnswerSelected(text); // Kirim jawaban ke parent
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
        ),
      ),
    );
  }
}
