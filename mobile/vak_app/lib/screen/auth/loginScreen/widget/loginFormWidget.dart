import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            // Ubah text jika sudah memiliki style
            labelText: 'Username',
            labelStyle: RegulerTextStyle.textTheme.bodySmall!.copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            // Ubah text jika sudah memiliki style
            labelText: 'Password',
            labelStyle: RegulerTextStyle.textTheme.bodySmall!.copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            // ganti ketika logika loginnya sudah ada
            onPressed: () => Navigator.pushNamed(context, AppRouteConstant.wrapperScreen),
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            // Ubah text jika sudah memiliki style
            child: Text(
              "Masuk",
              style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        // Redirect to Register Page
        // Center(child: Text("Belum punya akun?")),
        // const SizedBox(height: 20.0),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, AppRouteConstant.registrationScreen),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
            child: Text(
              'Daftar',
              style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                color: LocalColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}