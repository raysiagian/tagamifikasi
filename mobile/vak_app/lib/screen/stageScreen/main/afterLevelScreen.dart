import 'package:GamiLearn/models/topik.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/screen/stageScreen/widget/scoreBoardwidget.dart';
import 'package:GamiLearn/style/localColor.dart';

class AfterLevelScreen extends StatefulWidget {
  final Topik topik;

  const AfterLevelScreen({super.key, required this.topik,});

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
               child: Center(
                 child: Column(
                   children: [
                     ScoreBoardWidget(topik: widget.topik,),
                      const SizedBox(height: 40),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: LocalColor.primary,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //       vertical: 12, 
                      //       horizontal: 30
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Text(
                      //     "Lanjut",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      // ),
                   ],
                 ),
               ),
              ),
          ),
        ),
      ),
    );
  }
}
