// services/username_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';

class UsernameService {
  // Replace with your API URL

  Future<String> generateUsername(String fullName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/get-username'), // Replace with your endpoint
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MWEyNmI1ZWY5MWRmZGNmOTEyNjEiLCJlbWFpbCI6Im5hcmVuZHJhb3R1c29uZUBnbWFpbC5jb20iLCJyb2xlIjoibWFuYWdlciIsImlhdCI6MTc1ODc5NjgxMiwiZXhwIjoxNzYwMDkyODEyfQ.uyH-D8npc5ONOnQps75eJlDP1gia5G3U3g4Sx8Hchcc',
        },
        body: jsonEncode({'fullName': fullName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data']['username'];
        } else {
          throw Exception(data['message'] ?? 'Failed to generate username');
        }
      } else {
        throw Exception('Failed to generate username: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
