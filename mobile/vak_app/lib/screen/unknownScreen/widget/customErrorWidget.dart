import 'package:flutter/material.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

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
                  image: AssetImage('assets/images/component/HiFi-Error.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
        
            const SizedBox(height: 30,),
            Text(
              "404",
              style: BoldTextStyle.textTheme.titleLarge?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 5,),
            Text(
              "Ups, ada yang salah!",
              style: RegulerTextStyle.textTheme.bodyMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
             Text(
              "Coba periksa koneksi internet atau coba lagi nanti",
              style: RegulerTextStyle.textTheme.bodyMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}