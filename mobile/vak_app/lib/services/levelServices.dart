import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/level.dart';
import '../models/mataPelajaran.dart'; // Import model MataPelajaran
import 'auth_services.dart'; // Ambil token

class LevelService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  // Fungsi untuk mengambil daftar level berdasarkan mata pelajaran
  Future<List<Level>> fetchLevelsByMataPelajaran(int idMataPelajaran) async {
    final url = Uri.parse("$baseUrl/matapelajaran/$idMataPelajaran/levels");
    final token =
        await AuthService().getToken(); // Ambil token dari SharedPreferences

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Level.fromJson(item)).toList();
      } else {
        throw Exception(
            "Gagal mengambil level untuk mata pelajaran ini. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
