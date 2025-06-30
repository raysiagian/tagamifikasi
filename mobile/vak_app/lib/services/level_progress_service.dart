import 'package:GamiLearn/constant/baseUrl.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LevelProgressService {
  Future<Map<String, dynamic>> cekKelulusanLevel({
    required int id_user,
    required int id_level,
  }) async {
    final url = Uri.parse('$baseUrl/cek-kelulusan-level');
    final token = await AuthService().getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id_user': id_user,
          'id_level': id_level,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'status': data['status'] ?? 'failed',
          'boleh_lanjut': data['boleh_lanjut_level'] ?? false,
          'message': data['message'] ?? 'Tidak ada pesan dari server',
          'topik_terakhir': data['topik_terakhir'],
          'jumlah_bintang': data['jumlah_bintang'] ?? 0,
          'is_error': false,
        };
      } else {
        return {
          'status': 'error',
          'message': data['message'] ?? 'Terjadi kesalahan server',
          'is_error': true,
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Terjadi kesalahan jaringan: $e',
        'is_error': true,
      };
    }
  }
}