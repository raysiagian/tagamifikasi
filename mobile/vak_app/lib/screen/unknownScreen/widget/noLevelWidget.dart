import 'package:flutter/material.dart';

class NoLevelWidget extends StatelessWidget {
  const NoLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 245,
          height: 296,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/component/HiFi-No Content.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 30,),
        const Text(
          "Tidak ada Level Tersedia",
        ),

      ],
    );
  }
}