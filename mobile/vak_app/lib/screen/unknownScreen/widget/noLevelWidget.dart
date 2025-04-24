import 'package:flutter/material.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';

class NoLevelWidget extends StatelessWidget {
  const NoLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 480,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Text(
              "Tidak ada Level Tersedia",
              style: RegulerTextStyle.textTheme.bodyMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
        
          ],
        ),
      ),
    );
  }
}