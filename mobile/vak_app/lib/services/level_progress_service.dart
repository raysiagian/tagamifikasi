import 'package:GamiLearn/constant/baseUrl.dart';
import 'package:GamiLearn/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LevelProgressService {
  Future<Map<String, dynamic>> cekKelulusanLevel({
    required int idUser,
    // required int idMataPelajaran,
    required int idLevel,
  }) async {
    final url = Uri.parse(baseUrl + "/cek-kelulusan-level");

    // Mengambil token untuk autentikasi
    final token = await AuthService().getToken(); 

    try {
      // Mengirim request POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Mengirimkan token
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id_user': idUser,
          // 'id_mataPelajaran': idMataPelajaran,
          'id_level': idLevel,
        }),
      );

      // Mencetak status dan body untuk debugging
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      

      // Mengecek apakah status code 200
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Validasi jika data yang diperlukan ada
        if (data['boleh_lanjut'] != null && data['jumlah_benar'] != null) {
          return data;
        } else {
          throw Exception('Data yang diperlukan tidak ada dalam respons');
        }
      } else {
        // Jika status bukan 200, lempar error dengan pesan respons
        throw Exception('Gagal mengecek kelulusan level: ${response.body}');
      }
    } catch (e) {
      // Menangani error jika terjadi
      print('Error: $e');
      rethrow;  // Memunculkan kembali error jika perlu ditangani lebih lanjut di tempat lain
    }
  }
}
