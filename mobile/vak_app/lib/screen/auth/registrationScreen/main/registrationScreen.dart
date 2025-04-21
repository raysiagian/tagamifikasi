import 'package:flutter/material.dart';
import 'package:vak_app/screen/auth/registrationScreen/widget/registrationFormWidget.dart';
import 'package:vak_app/style/localColor.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Container(
            child: RegistrationFormWidget(),
                ),
        ),
        ),
    ),
    );
  }
}