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
        backgroundColor: LocalColor.primary,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 250,),
              Image.asset("assets/images/component/HiFi-Cat.png"),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: LoginFormWidget(),
          ),
        ), 
      ),
    );
  }
}