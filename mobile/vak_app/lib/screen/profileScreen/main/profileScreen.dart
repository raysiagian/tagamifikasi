import 'package:flutter/material.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/component/HiFI-Dummy.png'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama
                  Text(
                    'Player',
                    style: BoldTextStyle.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  // Username
                  Text(
                    'Player',
                    style: RegulerTextStyle.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Bergabung :',
                    style: RegulerTextStyle.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}