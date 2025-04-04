import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vak_app/constant/baseUrl.dart';

import '../models/mataPelajaran.dart';
import 'auth_services.dart';

class MataPelajaranService {

  Future<List<MataPelajaran>> fetchMataPelajaran() async {
    final url = Uri.parse(baseUrl + "/matapelajaran");
    final token = await AuthService().getToken(); // Ambil token yang tersimpan

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => MataPelajaran.fromJson(item)).toList();
      } else {
        throw Exception(
            "Gagal mengambil data matapelajaran. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
