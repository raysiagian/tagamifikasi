import 'package:flutter/material.dart';
import 'package:vak_app/screen/auth/forgetPasswordScreen/widget/forgetPasswordWidget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
      body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          child: ForgetPasswordFormWidget(),
        ),
      ),
    ));
  }
}