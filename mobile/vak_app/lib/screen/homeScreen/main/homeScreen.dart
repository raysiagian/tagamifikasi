import 'package:flutter/material.dart';
import 'package:vak_app/screen/stageScreen/main/stageScreen.dart';
import 'package:vak_app/style/localColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background/HiFi-Home Background.png"),
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
              _buildSubjectIcon(top: 290, left: 80, imagePath: "assets/images/component/HiFi-Komunikasi Subject Icon.png"),
              _buildSubjectIcon(top: 340, right: 20, imagePath: "assets/images/component/HiFi-Bahasa Indonesia Subject Icon.png"),
              _buildSubjectIcon(bottom: 160, left: 20, imagePath: "assets/images/component/HiFi-Bahasa Inggris Subject Icon.png"),
              _buildSubjectIcon(bottom: 20, left: 80, imagePath: "assets/images/component/HiFi-Matematika Subject Icon.png"),
              _buildSubjectIcon(bottom: 120, right: 50, imagePath: "assets/images/component/HiFi-Sains Subject Icon.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectIcon({double? top, double? bottom, double? left, double? right, required String imagePath}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StageScreen()),
          );
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
