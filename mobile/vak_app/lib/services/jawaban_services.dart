  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:vak_app/constant/baseUrl.dart';

  class JawabanService {
    Future<void> kirimJawaban({
      required int id_soal,
      required String jawaban_siswa,
      required String token,
    }) async {
      final url = Uri.parse(baseUrl + "/jawaban");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id_soal': id_soal,
          'jawaban_siswa': jawaban_siswa,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal mengirim jawaban: ${response.body}');
      }
    }
  }
