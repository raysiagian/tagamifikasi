import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';
import 'package:vak_app/models/users.dart';

import '../../../../services/auth_services.dart'; // Import model Users

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Tambahkan indikator loading

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    AuthService authService = AuthService();
    String username = _usernameController.text;
    String password = _passwordController.text;

    Users? user = await authService.login(username, password);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      // Jika login berhasil, navigasi ke halaman utama
      Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
    } else {
      // Jika login gagal, tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Login gagal! Periksa kembali username dan password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Username',
            labelStyle: RegulerTextStyle.textTheme.bodySmall!
                .copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          obscureText: true, // Tambahkan agar password tidak terlihat
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Password',
            labelStyle: RegulerTextStyle.textTheme.bodySmall!
                .copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _isLoading ? null : _login, // Nonaktifkan tombol saat loading
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white) // Tampilkan loading
                : Text(
                    "Login",
                    style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: 'Lupa password? ',
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: 'Reset di sini',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, AppRouteConstant.forgetPasswordScreen);
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(
                context, AppRouteConstant.registrationScreen),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
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
    ),
    );
  }
}
