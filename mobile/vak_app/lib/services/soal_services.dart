import 'dart:convert';
import 'package:http/http.dart' as http;
 
import '../models/level.dart';
import '../models/soal.dart';
import '../services/auth_services.dart'; // Untuk token autentikasi

class SoalService {
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Soal>> fetchSoalByLevel(int idLevel) async {
    final url = Uri.parse("$baseUrl/soal/level/$idLevel");
    final token = await AuthService().getToken(); // Ambil token dari AuthService

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

        LevelSoalResponse levelResponse = LevelSoalResponse.fromJson(jsonData);
        return levelResponse.soal;
      } else {
        throw Exception("Gagal mengambil soal. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error saat fetch soal: $e");
    }
  }
}
