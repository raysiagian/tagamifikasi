// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vak_app/constant/baseUrl.dart';
// import '../models/users.dart';

// class AuthService {

//   Future<Users?> register(String name, String username, String password,
//       String gender, String tanggalLahir) async {
//     final url = Uri.parse("$baseUrl/register");
//     final response = await http.post(
//       url,
//       body: {
//         'name': name,
//         'username': username,
//         'password': password,
//         'gender': gender,
//         'role': 'user', // Default role sebagai user
//         'tanggal_lahir': tanggalLahir, // Tambahkan tanggal lahir
//       },
//     );

//     if (response.statusCode == 201) {
//       // Perbaikan dari status 200 ke 201
//       final data = json.decode(response.body);
//       final token = data['access_token'];
//       final user = Users.fromJson(data['user']);

//       // Simpan token ke SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', token);

//       return user;
//     } else {
//       return null;
//     }
//   }

//   Future<Users?> login(String username, String password) async {
//     final url = Uri.parse("$baseUrl/login");
//     final response = await http.post(
//       url,
//       body: {
//         'username': username,
//         'password': password,
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final token = data['access_token'];
//       final user = Users.fromJson(data['user']);

//       // Simpan token ke SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', token);
      

//       return user;
//     } else {
//       return null;
//     }
//   }

//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//   }

//   Future<Users?> getUser() async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');

//   if (token != null) {
//     final response = await http.get(
//       Uri.parse('$baseUrl/user'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return Users.fromJson(data);
//     } else {
//       throw Exception('Failed to load user: ${response.body}');
//     }
//   } else {
//     throw Exception('Token not found');
//   }
// }

//   Future<bool> resetPassword({
//   required String username,
//   required String tanggalLahir,
//   required String passwordBaru,
//   required String passwordBaruConfirmation,
// }) async {
//   final url = Uri.parse(baseUrl + "/lupa-password");

//   final response = await http.post(
//     url,
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({
//       "username": username,
//       "tanggal_lahir": tanggalLahir,
//       "password_baru": passwordBaru,
//       "password_baru_confirmation": passwordBaru,
//     }),
//   );

//   if (response.statusCode == 200) {
//     return true; // Password berhasil diubah
//   } else {
//     return false; // Gagal
//   }
// }


// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/users.dart';

class AuthService {
  Future<Users?> register(String name, String username, String password,
      String gender, String tanggalLahir) async {
    final url = Uri.parse("$baseUrl/register");
    final response = await http.post(
      url,
      body: {
        'name': name,
        'username': username,
        'password': password,
        'gender': gender,
        'role': 'user', // Default role sebagai user
        'tanggal_lahir': tanggalLahir,
      },
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final token = data['access_token'];
      final user = Users.fromJson(data['user']);

      // Simpan token & user ID ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setInt('userId', user.idUser!); // << SIMPAN ID USER

      return user;
    } else {
      return null;
    }
  }

  Future<Users?> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token'];
      final user = Users.fromJson(data['user']);

      // Simpan token & user ID ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setInt('userId', user.idUser!); // << SIMPAN ID USER

      return user;
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId'); // Hapus userId juga
  }

  Future<Users?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Users.fromJson(data);
      } else {
        throw Exception('Failed to load user: ${response.body}');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  Future<bool> resetPassword({
    required String username,
    required String tanggalLahir,
    required String passwordBaru,
    required String passwordBaruConfirmation,
  }) async {
    final url = Uri.parse(baseUrl + "/lupa-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "tanggal_lahir": tanggalLahir,
        "password_baru": passwordBaru,
        "password_baru_confirmation": passwordBaruConfirmation,
      }),
    );

    return response.statusCode == 200;
  }
}

