import 'package:flutter/material.dart';

import '../models/users.dart';
import '../services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  Users? _user;
  String? _token;

  Users? get user => _user;
  String? get token => _token;

  final AuthService _authService = AuthService();

  Future<bool> login(String username, String password) async {
    try {
      final response = await _authService.login(username, password);
      if (response != null) {
        _user = response;
        _token = await _authService.getToken();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Login error: $e");
    }
    return false;
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
