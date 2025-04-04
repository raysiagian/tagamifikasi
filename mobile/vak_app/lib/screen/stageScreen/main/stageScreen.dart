import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/widget/unitWidget.dart';

class StageScreen extends StatefulWidget {
  final int idMataPelajaran;

  const StageScreen({super.key, required this.idMataPelajaran});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bermain")),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background/HiFi-Stage Background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
              child: UnitWidget(idMataPelajaran: widget.idMataPelajaran),
            ),
          ),
        ],
      ),
    );
  }
}