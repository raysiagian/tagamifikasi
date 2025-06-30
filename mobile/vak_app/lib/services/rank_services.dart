import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GamiLearn/constant/baseUrl.dart';
import 'package:GamiLearn/services/auth_services.dart';

class RankService {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> fetchRank() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/rank-saya'),
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
          // Return the entire response data or specific fields as needed
          return {
            'id_user': responseData['id_user'],
            'total_bintang': responseData['total_bintang'],
            'nama_rank': responseData['nama_rank'],
          };
        } else {
          throw Exception(responseData['message'] ?? 'Gagal memuat rank');
        }
      } else {
        throw Exception('Gagal memuat rank: ${response.statusCode}');
      }
    } catch (e) {
      print('[EXCEPTION] in fetchRank: $e');
      rethrow;
    }
  }
}