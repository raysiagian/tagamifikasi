import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Add this import
import 'package:GamiLearn/constant/baseUrl.dart';
import '../models/soal.dart';
import '../services/auth_services.dart';

class SoalService {
  Future<List<Soal>> fetchSoalByTopik(int id_topik) async {
    final url = Uri.parse("$baseUrl/soal/topik/$id_topik");
    debugPrint("Fetching questions for topic ID: $id_topik");
    debugPrint("API Endpoint: $url");

    try {
      final token = await AuthService().getToken();
      if (token == null) throw Exception("Authentication token not found");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: 10));

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        
        if (jsonData['success'] != true) {
          throw Exception("API request unsuccessful: ${jsonData['message']}");
        }

        if (jsonData['data'] == null || jsonData['data'] is! List) {
          throw Exception("Invalid data format received from API");
        }

        final soalList = (jsonData['data'] as List)
            .map((item) => Soal.fromJson(item as Map<String, dynamic>))
            .toList();

        debugPrint("Successfully parsed ${soalList.length} questions");
        return soalList;
      } else {
        final error = jsonDecode(response.body)?['message'] ?? 
                     'Unknown error (Status: ${response.statusCode})';
        throw Exception(error);
      }
    } catch (e) {
      debugPrint("Error in fetchSoalByTopik: $e");
      throw Exception("Failed to load questions: ${e.toString()}");
    }
  }
}