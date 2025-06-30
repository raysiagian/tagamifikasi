import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/soal.dart';
import '../services/auth_services.dart';

class SoalService {
  Future<List<Soal>> fetchSoalByTopik(int id_topik) async {
    final url = Uri.parse("$baseUrl/soal/topik/$id_topik");
    final token = await AuthService().getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] == true && jsonData['data'] is List) {
          return (jsonData['data'] as List)
              .map((item) => Soal.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception("Format response tidak valid");
        }
      } else {
        final error = jsonDecode(response.body)?['message'] ?? 'Unknown error';
        throw Exception("Gagal mengambil soal: $error");
      }
    } catch (e) {
      throw Exception("Error saat fetch soal: ${e.toString()}");
    }
  }
}