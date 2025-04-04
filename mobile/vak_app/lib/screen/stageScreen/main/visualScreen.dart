import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class VisualScreen extends StatefulWidget {
  final Soal soal;
  VisualScreen({Key? key, required this.soal}) : super(key: key);

  @override
  State<VisualScreen> createState() => _VisualScreenState();
}

class _VisualScreenState extends State<VisualScreen> {
  String? selectedAnswer;

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
                    "assets/images/component/HiFi Dummy.png"), // Fallback jika media null
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
                      minimumSize: Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(16),
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
                      softWrap: true,
                      overflow: TextOverflow.visible,
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