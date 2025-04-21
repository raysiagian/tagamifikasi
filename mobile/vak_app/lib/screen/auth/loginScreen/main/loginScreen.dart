import 'package:flutter/material.dart';
import 'package:vak_app/screen/auth/loginScreen/widget/loginFormWidget.dart';
import 'package:vak_app/style/localColor.dart';

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
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: LoginFormWidget(),
          ),
        ),
      ),
    );
  }
}