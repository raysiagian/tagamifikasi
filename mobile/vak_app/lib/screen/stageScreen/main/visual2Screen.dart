import 'package:flutter/material.dart';
import 'package:vak_app/models/soal.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

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
  String? selectedOption;
  late Map<String, String?> options;

  @override
  void initState() {
    super.initState();
    options = {
      'A': widget.soal.opsiA,
      'B': widget.soal.opsiB,
    };
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
            onPressed: () {
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
