import 'package:flutter/material.dart';
import 'package:GamiLearn/screen/homeScreen/main/homeScreen.dart';
import 'package:GamiLearn/screen/profileScreen/main/profileScreen.dart';
import 'package:GamiLearn/screen/statisticScreen/main/statisticPage.dart';
import 'package:GamiLearn/screen/wrapper/widget/bottomNavbarWidget.dart';
import 'package:GamiLearn/services/backgroundsound_service.dart'; // tambahkan ini

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int selectedIndex = 0;
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    // Background music
    // BackgroundSoundService().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageViewController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          HomeScreen(),
          StatisticScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavbarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
            pageViewController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

