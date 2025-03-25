import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/widget/unitWidget.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bermain")),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background/HiFi-Stage Background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UnitWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}