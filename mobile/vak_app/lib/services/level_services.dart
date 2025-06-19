import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/level.dart';
import 'auth_services.dart'; // Ambil token

class LevelService {
  // final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Level>> fetchLevels() async {
  final url = Uri.parse(baseUrl + "/levels");
  final token = await AuthService().getToken();

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

      // Ambil list dari field 'data'
      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        return (jsonData['data'] as List)
            .map((item) => Level.fromJson(item))
            .toList();
      } else {
        throw Exception("Response JSON tidak memiliki field 'data' berupa list.");
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
