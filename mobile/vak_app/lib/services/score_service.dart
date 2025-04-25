import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:GamiLearn/models/users.dart';
class SkorService {
  final AuthService _authService = AuthService();

    Future<Map<String, dynamic>> fetchSkorAkhirLevel({
    required int idMataPelajaran,
    required int idLevel,
  }) async {
    final token = await _authService.getToken();
    final user = await _authService.getUser();

    if (token == null || user == null) {
      throw Exception('Token atau data pengguna tidak ditemukan');
    }

    final url = Uri.parse(
      "$baseUrl/skor-akhir-level?id_mataPelajaran=$idMataPelajaran&id_level=$idLevel",
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


 Future<Map<String, dynamic>> fetchSkorTerbaru() async {
    final token = await _authService.getToken();
    final user = await _authService.getUser();

    if (token == null || user == null) {
      throw Exception('Token atau data pengguna tidak ditemukan');
    }

    // Menggunakan token saja untuk autentikasi dan tidak menggunakan id_user di URL
    final url = Uri.parse("$baseUrl/skor-terbaru");
    // final url = Uri.parse("$baseUrl/skor-terbaru?id_user=${user.idUser}");


    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        if (data['status'] == 'success') {
          return data;
        } else {
          throw Exception('Gagal: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Format data tidak valid');
      }
    } else {
      throw Exception('Gagal mengambil skor terbaru: ${response.statusCode}');
    }
  }

  // fetch list nilai rekap
  Future<Map<String, dynamic>> fetchListRekap({
  required int idMataPelajaran,
  required int idLevel,
}) async {
  final token = await _authService.getToken();
  final user = await _authService.getUser();

  if (token == null || user == null) {
    throw Exception('Token atau data pengguna tidak ditemukan');
  }

  final url = Uri.parse(
    "$baseUrl/rekap-skor?id_user=${user.idUser}&id_mataPelajaran=$idMataPelajaran&id_level=$idLevel",
  );

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  print(response.body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      return data['data'];
    } else {
      throw Exception('Gagal: ${data['message'] ?? 'Unknown error'}');
    }
  } else {
    throw Exception('Gagal mengambil rekap: ${response.statusCode}');
  }
}

  Future<int> fetchJumlahBenarTerbaru(int idMataPelajaran, int idLevel) async {
    final token = await _authService.getToken();
    final user = await _authService.getUser();

    if (token == null || user == null) {
      throw Exception('Token atau data pengguna tidak ditemukan');
    }

    final url = Uri.parse('$baseUrl/skor-akhir-level?id_mataPelajaran=$idMataPelajaran&id_level=$idLevel');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['jumlah_benar'] ?? 0;
    } else {
      throw Exception('Gagal mengambil skor akhir');
    }
  }


}