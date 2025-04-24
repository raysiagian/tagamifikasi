import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vak_app/constant/baseUrl.dart';
import 'package:vak_app/services/auth_services.dart';
import 'package:vak_app/models/users.dart';
class SkorService {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> fetchSkorAkhirLevel({
    required int idMataPelajaran,
    required int idLevel,
  }) async {
    final token = await _authService.getToken();
    final user = await _authService.getUser();

    if (token == null || user == null) {
      throw Exception('Token atau data pengguna tidak ditemukan');
    }

    final url = Uri.parse(
      "$baseUrl/skor-akhir-level?id_mataPelajaran=$idMataPelajaran&id_level=$idLevel",
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        if (data['status'] == 'success') {
          return data;
        } else {
          throw Exception('Gagal: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Format data tidak valid');
      }
    } else {
      throw Exception('Gagal mengambil skor akhir: ${response.statusCode}');
    }
  }
}