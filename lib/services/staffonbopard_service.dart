// services/staff_onboarding_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';

class StaffOnboardingService {
  Future<Map<String, dynamic>> createStaff(
    Map<String, dynamic> staffData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/admin/create-new-user',
        ), // Replace with your endpoint
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MWEyNmI1ZWY5MWRmZGNmOTEyNjEiLCJlbWFpbCI6Im5hcmVuZHJhb3R1c29uZUBnbWFpbC5jb20iLCJyb2xlIjoibWFuYWdlciIsImlhdCI6MTc1ODc5NjgxMiwiZXhwIjoxNzYwMDkyODEyfQ.uyH-D8npc5ONOnQps75eJlDP1gia5G3U3g4Sx8Hchcc',
        },
        body: jsonEncode(staffData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return {
            'success': true,
            'message': data['message'] ?? 'Staff created successfully',
            'data': data['data'],
          };
        } else {
          return {
            'success': false,
            'message': data['message'] ?? 'Failed to create staff',
          };
        }
      } else {
        throw Exception('Failed to create staff: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
