import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vak_app/constant/baseUrl.dart';
import 'package:vak_app/services/auth_services.dart';
import 'package:vak_app/models/users.dart';

class SkorService {
  Future<Map<String, dynamic>> fetchSkorAkhir(int idMataPelajaran) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final user = await authService.getUser(); // ambil user dari token

    if (token == null || user == null) {
      throw Exception('Token atau data pengguna tidak ditemukan');
    }

    final idUser = user.idUser; // pastikan model Users punya properti `id`

    final url = Uri.parse(
      "$baseUrl/skor-akhir?id_user=$idUser&id_mataPelajaran=$idMataPelajaran"
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil skor akhir: ${response.body}');
    }
  }
}
