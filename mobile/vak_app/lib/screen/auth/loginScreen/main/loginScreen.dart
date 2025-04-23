import 'package:flutter/material.dart';
import 'package:vak_app/screen/auth/loginScreen/widget/loginFormWidget.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // tambahkan gambar
            const SizedBox(height: 40,),
            Text(
              "Selamat Datang",
              style: RegulerTextStyle.textTheme.bodyMedium?.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5,),
            Text(
              "Gamilearn",
              style: BoldTextStyle.textTheme.displaySmall?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 40,),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: LoginFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}