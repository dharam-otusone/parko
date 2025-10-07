import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import 'package:parko/services/storage_services.dart';

class ApiService {
  final StorageService _storageService = StorageService();

  Future<Map<String, dynamic>> postRequest(Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/admin/login');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  /// Example: Authenticated GET Request
  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final token = await _storageService.getAccessToken();
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
