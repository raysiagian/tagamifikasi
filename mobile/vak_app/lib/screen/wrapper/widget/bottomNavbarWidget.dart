import 'package:flutter/material.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
   return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      currentIndex: selectedIndex,
      elevation: 0,
      iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
             "assets/images/component/HiFi-Home Icon.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Image.asset(
        //      "assets/images/component/HiFi-Statistic Icon.png",
        //     height: 30,
        //     width: 30,
        //     fit: BoxFit.cover,
        //   ),
        //   label: 'Statistik',
        // ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/images/component/HiFi-Profile Icon.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          label: 'Profil',
        ),
      ],
      onTap: onItemTapped,
    );
  }
}
