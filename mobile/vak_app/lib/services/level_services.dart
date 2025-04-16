import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vak_app/constant/baseUrl.dart';
import '../models/level.dart';
import '../models/mataPelajaran.dart'; // Import model MataPelajaran
import 'auth_services.dart'; // Ambil token

class LevelService {
  // final String baseUrl = "http://10.0.2.2:8000/api";

  // Fungsi untuk mengambil daftar level berdasarkan ID Mata Pelajaran
  Future<List<Level>> fetchLevelsByMataPelajaran(int idMataPelajaran) async {
    final url = Uri.parse(baseUrl + "/matapelajaran/$idMataPelajaran/levels");
    final token = await AuthService().getToken(); // Ambil token

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          return jsonData.map((item) => Level.fromJson(item)).toList();
        } else {
          throw Exception("Response bukan berupa list.");
        }
      } else {
        throw Exception(
            "Gagal mengambil level. Status: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error saat fetch level: $e");
    }
  }
}
