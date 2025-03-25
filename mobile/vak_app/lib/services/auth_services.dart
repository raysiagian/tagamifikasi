import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/users.dart';

class AuthService {
  final String baseUrl =
      "http://10.0.2.2:8000/api"; // Ganti dengan URL API Anda

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
        'tanggal_lahir': tanggalLahir, // Tambahkan tanggal lahir
      },
    );

    if (response.statusCode == 201) {
      // Perbaikan dari status 200 ke 201
      final data = json.decode(response.body);
      final token = data['access_token'];
      final user = Users.fromJson(data['user']);

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

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

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return user;
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
