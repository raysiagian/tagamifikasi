import 'package:flutter/material.dart';
import 'package:vak_app/routes/appRouteConstant.dart';
import 'package:vak_app/style/localColor.dart';
import 'package:vak_app/style/regulerTextStyle.dart';

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

  bool isMale = false;
  bool isFemale = false;

  // Pilih Tanggal Lahir
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale("id", "ID"),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
      print("Tanggal yang dipilih: ${picked.toString()}");
    }
  }

  // Update pilihan jenis kelamin agar hanya bisa memilih satu
  void _updateGenderSelection(String gender) {
    setState(() {
      if (gender == "Male") {
        isMale = true;
        isFemale = false;
      } else if (gender == "Female") {
        isMale = false;
        isFemale = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Nama
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: 'Nama',
            labelStyle: RegulerTextStyle.textTheme.bodySmall!
                .copyWith(color: Colors.black),
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
            const SizedBox(height: 5),

            CheckboxListTile(
              title: const Text("Laki-laki"),
              value: isMale,
              onChanged: (bool? value) {
                _updateGenderSelection("Male");
              },
            ),
            CheckboxListTile(
              title: const Text("Perempuan"),
              value: isFemale,
              onChanged: (bool? value) {
                _updateGenderSelection("Female");
              },
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Username
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

        // Password
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

        // Tombol Daftar
        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              String selectedGender = isMale
                  ? "Laki-laki"
                  : isFemale
                      ? "Perempuan"
                      : "Belum dipilih";

              print("Nama: ${_nameController.text}");
              print("Tanggal Lahir: ${_dateOfBirthController.text}");
              print("Username: ${_usernameController.text}");
              print("Jenis Kelamin: $selectedGender");

              Navigator.pushNamed(context, AppRouteConstant.wrapperScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: LocalColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              "Daftar",
              style: RegulerTextStyle.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20.0),

        // Tombol Masuk
        SizedBox(
          height: 44,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouteConstant.loginScreen),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            child: Text(
              'Masuk',
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
