import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/widget/scoreBoardwidget.dart';
import 'package:vak_app/style/localColor.dart';

class AfterLevelScreen extends StatefulWidget {
  const AfterLevelScreen({super.key});

  @override
  State<AfterLevelScreen> createState() => _AfterLevelScreenState();
}

class _AfterLevelScreenState extends State<AfterLevelScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
             image: DecorationImage(
              image: AssetImage("assets/images/background/HiFi-After Level Background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: LocalColor.transparent,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
                  child: ScoreBoardWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}