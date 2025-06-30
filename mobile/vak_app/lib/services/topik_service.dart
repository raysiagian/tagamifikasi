import 'dart:convert';
import 'package:GamiLearn/models/topik.dart';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import 'auth_services.dart'; // Ambil token

class TopikService {
  // final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Topik>> fetchtopiks(int idLevel) async {
    // perbaiki ketika sudah benar
  // final url = Uri.parse(baseUrl + "/topik/$idLevel");
  final url = Uri.parse(baseUrl + "/level/$idLevel/topik");
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
            .map((item) => Topik.fromJson(item))
            .toList();
      } else {
        throw Exception("Response JSON tidak memiliki field 'data' berupa list.");
      }
    } else {
      throw Exception(
          "Gagal mengambil topik. Status: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    throw Exception("Error saat fetch topik: $e");
  }
}

}
