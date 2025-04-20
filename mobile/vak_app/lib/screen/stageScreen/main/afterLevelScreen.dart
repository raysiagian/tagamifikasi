import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/widget/scoreBoardwidget.dart';
import 'package:vak_app/style/localColor.dart';

class AfterLevelScreen extends StatefulWidget {
  final int idMataPelajaran;
  final int idLevel;

  const AfterLevelScreen({super.key, required this.idMataPelajaran,required this.idLevel,});

  @override
  State<AfterLevelScreen> createState() => _AfterLevelScreenState();
}

class _AfterLevelScreenState extends State<AfterLevelScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: LocalColor.greenBackground,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/background/HiFi-After Level Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
             child: Container(
                width: screenWidth * 0.8, // Lebar 40% dari total layar
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
               child: ScoreBoardWidget(idMataPelajaran: widget.idMataPelajaran, idLevel: widget.idLevel,),
              ),
          ),
        ),
      ),
    );
  }
}
