import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:GamiLearn/screen/stageScreen/main/stageScreen.dart';
import 'package:GamiLearn/services/score_service.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  final int idLevel;

  const ScoreBoardWidget({super.key, required this.idLevel});

  @override
  _ScoreBoardWidgetState createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  late Future<Map<String, dynamic>> _levelResults;
  final SkorService _skorService = SkorService();

  @override
  void initState() {
    super.initState();
    _levelResults = _skorService.fetchJumlahBenarTerbaru(widget.idLevel);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _levelResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final results = snapshot.data!;
        final stars = results['stars'] as int;
        final correctAnswers = results['correctAnswers'] as int;
        final levelExplanation = results['levelExplanation'] as String;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Level Selesai!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: LocalColor.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(levelExplanation),
              const SizedBox(height: 30),
              // Star Display
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Icon(
                    index < stars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Correct Answers Display
              Text(
                "Jawaban Benar: $correctAnswers",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: LocalColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12, 
                    horizontal: 30
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Lanjut",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}