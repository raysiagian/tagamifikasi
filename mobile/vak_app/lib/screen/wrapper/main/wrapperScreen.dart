import 'package:flutter/material.dart';
import 'package:vak_app/screen/homeScreen/main/homeScreen.dart';
import 'package:vak_app/screen/profileScreen/main/profileScreen.dart';
import 'package:vak_app/screen/statisticScreen/main/statisticPage.dart';
import 'package:vak_app/screen/wrapper/widget/bottomNavbarWidget.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int selectedIndex = 0;
  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageViewController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          HomeScreen(),
          StatisticPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavbarWidget(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          setState(() {
            selectedIndex = index;
            pageViewController.animateTo(
              MediaQuery.of(context).size.width * index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
