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
        backgroundColor: LocalColor.primary,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 0,),
              Image.asset("assets/images/component/HiFi-Cat.png"),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 650,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: RegistrationFormWidget(),
          ),
        ),
      )
    );
  }
}