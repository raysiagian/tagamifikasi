import 'package:flutter/material.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';
import '../../../../services/auth_services.dart';

class ForgetPasswordFormWidget extends StatefulWidget {
  const ForgetPasswordFormWidget({super.key});

  @override
  State<ForgetPasswordFormWidget> createState() => _ForgetPasswordFormWidgetState();
}

class _ForgetPasswordFormWidgetState extends State<ForgetPasswordFormWidget> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  DateTime? selectedDate;

  // Pilih Tanggal Lahir
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
      locale: const Locale("id", "ID"),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateOfBirthController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "Lupa",
          style: BoldTextStyle.textTheme.titleLarge!.copyWith(color: LocalColor.primary),
        ),
        const SizedBox(height: 5),
        Text(
          "Password",
          style: BoldTextStyle.textTheme.titleLarge!.copyWith(color: LocalColor.primary),
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Masukkan Username',
          ),
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: _dateOfBirthController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "Masukkan Tanggal Lahir",
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          controller: _newpasswordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Masukkan Password Baru',
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _confirmNewPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Konfirmasi Password Baru',
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final username = _usernameController.text;
              final tanggalLahir = _dateOfBirthController.text;
              final passwordBaru = _newpasswordController.text;
              final confirmPassword = _confirmNewPasswordController.text;

              if (username.isEmpty || tanggalLahir.isEmpty || passwordBaru.isEmpty || confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Semua field harus diisi")),
                );
                return;
              }

              if (passwordBaru != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Konfirmasi password tidak cocok")),
                );
                return;
              }

              final isSuccess = await AuthService().resetPassword(
                username: username,
                tanggalLahir: tanggalLahir,
                passwordBaru: passwordBaru,
                passwordBaruConfirmation: _confirmNewPasswordController.text,
              );

              if (isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password berhasil diubah")),
                );
                Navigator.pushNamed(context, AppRouteConstant.loginScreen);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Gagal mengubah password")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "Ubah Password",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 44,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, AppRouteConstant.loginScreen),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
            child: Text(
              'Login',
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
