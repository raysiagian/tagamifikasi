import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/users.dart';

class AuthService {

  // menyimpan token dan id user ketika login
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'id_user';

  Future<Users?> register(String name, String username, String password,
      String gender, String tanggalLahir) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'username': username,
          'password': password,
          'gender': gender,
          'role': 'user',
          'tanggal_lahir': tanggalLahir,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final token = data['access_token'] as String?;
        final userJson = data['user'] as Map<String, dynamic>?;
        
        if (token == null || userJson == null) {
          throw Exception('Invalid response format');
        }

        final user = Users.fromJson(userJson);
        await _saveAuthData(token, user.id_user);
        return user;
      }
      return null;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<Users?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access_token'] as String?;
        final userJson = data['user'] as Map<String, dynamic>?;
        
        if (token == null || userJson == null) {
          throw Exception('Invalid response format');
        }

        final user = Users.fromJson(userJson);
        await _saveAuthData(token, user.id_user);
        return user;
      }
      return null;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> _saveAuthData(String token, int? userId) async {
    if (userId == null) {
      throw Exception('User ID cannot be null');
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_userIdKey, userId);
  }

  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_userIdKey); // Now using consistent key
    } catch (e) {
      throw Exception('Failed to get user ID: $e');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userIdKey);
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<Users?> getUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Users.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get user failed: $e');
    }
  }

  Future<bool> resetPassword({
    required String username,
    required String tanggalLahir,
    required String passwordBaru,
    required String passwordBaruConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/lupa-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "tanggal_lahir": tanggalLahir,
          "password_baru": passwordBaru,
          "password_baru_confirmation": passwordBaruConfirmation,
        }),
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
}