import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:GamiLearn/models/users.dart';

import '../../../../services/auth_services.dart';
class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
      Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Login gagal! Periksa kembali username dan password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
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
          obscureText: true,
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
        const SizedBox(height: 20),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Lupa password? ',
              style: TextStyle(color: Colors.black87),
              children: [
                TextSpan(
                  text: 'Ubah disini',
                  style: TextStyle(
                    color: LocalColor.primary,
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
    );
  }
}
