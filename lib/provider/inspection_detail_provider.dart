import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import 'dart:convert';

import '../models/inspection_detail_model.dart';

class InspectionDetailProvider with ChangeNotifier {
  InspectionDetail? _inspection;
  bool _isLoading = false;

  InspectionDetail? get inspection => _inspection;
  bool get isLoading => _isLoading;

  Future<void> fetchInspectionDetail(String id) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/admin/incomming-inspection/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MTRhMmRkOWZkYmM3M2JlNjk5NzMiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1ODgwMDcxNCwiZXhwIjoxNzYwMDk2NzE0fQ._ACTOMkXU9L0EVvbT84N-6F-AYg7CB9P56Lv-aC34ak',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _inspection = InspectionDetail.fromJson(data['data']);
      } else {
        throw Exception('Failed to load inspection details');
      }
    } catch (e) {
      print('Error fetching inspection: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
