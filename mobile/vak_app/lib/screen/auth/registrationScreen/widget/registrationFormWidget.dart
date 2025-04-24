import 'dart:convert';
import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:GamiLearn/routes/appRouteConstant.dart';
import 'package:GamiLearn/style/boldTextStyle.dart';
import 'package:GamiLearn/style/localColor.dart';
import 'package:GamiLearn/style/regulerTextStyle.dart';
import 'package:GamiLearn/models/users.dart';
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

    if (username.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username harus minimal 8 karakter.")),
      );
      return;
    }

    if (password.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password harus minimal 8 karakter.")),
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
        Navigator.pushNamed(context, AppRouteConstant.loginScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Registrasi gagal. Cek kembali data yang diinput.")),
        );
      }
    } catch (error) {
      debugPrint("Error saat registrasi: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         const SizedBox(height: 10),
        Text(
          "Daftar",
          style: BoldTextStyle.textTheme.titleLarge!.copyWith(color: LocalColor.primary),
        ),
        const SizedBox(height: 5),
        Text(
          "Akun",
          style: BoldTextStyle.textTheme.titleLarge!.copyWith(color: LocalColor.primary),
        ),
        const SizedBox(height: 10),
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
       // Pilih Jenis Kelamin
       // Pilih Jenis Kelamin
       // Pilih Jenis Kelamin - pakai button toggle
        Text(
          "Pilih Jenis Kelamin",
          style: RegulerTextStyle.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateGenderSelection("laki-laki"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isMale ? LocalColor.primary : Colors.grey[200],
                foregroundColor: isMale ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isMale ? Colors.transparent : Colors.grey, // border saat belum dipilih
                    width: 1.5,
                  ),
                ),
                elevation: isMale ? 2 : 0,
              ),
              child: const Text("Laki-laki"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _updateGenderSelection("perempuan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFemale ? LocalColor.primary : Colors.grey[200],
                foregroundColor: isFemale ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isFemale ? Colors.transparent : Colors.grey, // border saat belum dipilih
                    width: 1.5,
                  ),
                ),
                elevation: isFemale ? 2 : 0,
              ),
              child: const Text("Perempuan"),
            ),
          ),
        ],
      ),




        const SizedBox(height: 20),

        TextFormField(
          controller: _usernameController,
           validator: (value) {
            if (value == null || value.isEmpty) return 'Username wajib diisi';
            if (value.length < 8) return 'Minimal 8 karakter';
            return null;
          },
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Username',
          ),
        ),
        const SizedBox(height: 20),

        TextFormField(
          controller: _passwordController,
           validator: (value) {
            if (value == null || value.isEmpty) return 'password wajib diisi';
            if (value.length < 8) return 'Minimal 8 karakter';
            return null;
          },
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
        SizedBox(
          height: 44,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(
                context, AppRouteConstant.loginScreen),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
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
