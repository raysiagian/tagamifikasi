import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';
import 'package:vak_app/models/users.dart';
import '../../../../services/auth_services.dart';

class RegistrationFormWidget extends StatefulWidget {
  const RegistrationFormWidget({super.key});

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isMale = false;
  bool isFemale = false;
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

  // Update pilihan jenis kelamin agar hanya bisa memilih satu
  void _updateGenderSelection(String gender) {
    setState(() {
      if (gender == "laki-laki") {
        isMale = true;
        isFemale = false;
      } else if (gender == "perempuan") {
        isMale = false;
        isFemale = true;
      }
    });
  }

  // Fungsi untuk menangani registrasi
  void _register() async {
    String name = _nameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String gender = isMale
        ? "laki-laki"
        : isFemale
            ? "perempuan"
            : "";
    String tanggalLahir = _dateOfBirthController.text;

    if (name.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        gender.isEmpty ||
        tanggalLahir.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap isi semua field dengan benar!")),
      );
      return;
    }

    try {
      Users? user = await _authService.register(
          name, username, password, gender, tanggalLahir);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi berhasil! Silakan login.")),
        );
        Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Registrasi gagal. Cek kembali data yang diinput.")),
        );
      }
    } catch (error) {
      print("Error saat registrasi: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nama',
          ),
        ),
        const SizedBox(height: 20.0),

        // Pilih Tanggal Lahir
        TextFormField(
          controller: _dateOfBirthController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "Pilih Tanggal Lahir",
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 20.0),

        // Pilih Jenis Kelamin
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pilih Jenis Kelamin"),
            CheckboxListTile(
              title: const Text("Laki-laki"),
              value: isMale,
              onChanged: (bool? value) {
                _updateGenderSelection("laki-laki");
              },
            ),
            CheckboxListTile(
              title: const Text("Perempuan"),
              value: isFemale,
              onChanged: (bool? value) {
                _updateGenderSelection("perempuan");
              },
            ),
          ],
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Username',
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
          ),
        ),
        const SizedBox(height: 30),

        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              "Daftar",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
