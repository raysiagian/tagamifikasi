import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import 'package:GamiLearn/services/auth_services.dart';

class SkorService {
  final AuthService _authService = AuthService();

Future<Map<String, dynamic>> fetchJumlahBenarTerbaru(int idLevel) async {
    try {
      print('[DEBUG] Starting fetchJumlahBenarTerbaru for level $idLevel');
      
      final token = await _authService.getToken();
      final user = await _authService.getUser();
      print('[DEBUG] Token and user fetched');

      if (token == null || user == null) {
        print('[ERROR] Token or user is null');
        throw Exception('Token atau data pengguna tidak ditemukan');
      }

      final url = Uri.parse('$baseUrl/bintang-saya/$idLevel');
      print('[DEBUG] Request URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('[DEBUG] Response received: ${response.statusCode}');
      print('[DEBUG] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        
        if (body['status'] == 'success') {
          print('[DEBUG] Successfully parsed response');
          return {
            'stars': body['jumlah_bintang'] ?? 0,
            'correctAnswers': body['jumlah_benar'] ?? 0,
            'levelExplanation': body['penjelasan_level'] ?? '',
          };
        } else {
          print('[ERROR] API returned error status: ${body['message']}');
          throw Exception(body['message'] ?? 'Unknown error');
        }
      } else {
        print('[ERROR] HTTP Error: ${response.statusCode}');
        throw Exception('Failed to load results: ${response.statusCode}');
      }
    } catch (e) {
      print('[EXCEPTION] in fetchJumlahBenarTerbaru: $e');
      rethrow;
    }
  }
  
  // Di file score_service.dart
  // Future<List<dynamic>> fetchAllLevelScores() async {
  //   final token = await _authService.getToken();
    
  //   if (token == null) {
  //     throw Exception('Token tidak ditemukan');
  //   }

  //   final response = await http.get(
  //     Uri.parse('$baseUrl/rekap-s'), // Endpoint tanpa parameter
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Gagal memuat skor: ${response.statusCode}');
  //   }
  // }  
    Future<List<dynamic>> fetchAllLevelScores() async {
      try {
        final token = await _authService.getToken();
        if (token == null) {
          throw Exception('Token tidak ditemukan');
        }

        final response = await http.get(
          Uri.parse('$baseUrl/skor'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        print('[DEBUG] Response status: ${response.statusCode}');
        print('[DEBUG] Response body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          
          if (responseData['status'] == 'success') {
            return responseData['data'] as List<dynamic>;
          } else {
            throw Exception(responseData['message'] ?? 'Gagal memuat skor');
          }
        } else {
          throw Exception('Gagal memuat skor: ${response.statusCode}');
        }
      } catch (e) {
        print('[EXCEPTION] in fetchAllLevelScores: $e');
        rethrow;
      }
    }
  
}