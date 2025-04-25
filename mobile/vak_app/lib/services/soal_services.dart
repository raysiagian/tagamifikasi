import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/soal.dart';
import '../services/auth_services.dart';

class SoalService {
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
      print(response);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        // Cek apakah data memiliki key "soal"
        if (jsonData.containsKey("soal")) {
          List<dynamic> soalList = jsonData["soal"];
          return soalList.map((item) => Soal.fromJson(item)).toList();
        } else {
          throw Exception("Format data tidak sesuai: Key 'soal' tidak ditemukan");
        }
      } else {
        throw Exception("Gagal mengambil soal. Status: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error saat fetch soal: $e");
    }
  }
}