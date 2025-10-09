import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import 'package:parko/models/forming_inspection_detail_model.dart';
import '../models/forming_inspection_model.dart';

class FormingInpectionDetailProvider extends ChangeNotifier {
  FormingInspection? _inspection;
  bool _isLoading = false;
  String? _error;

  FormingInspection? get inspection => _inspection;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFormingInspectionById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/forming-process-inspection/$id'),
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MTRhMmRkOWZkYmM3M2JlNjk5NzMiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1ODgwMDcxNCwiZXhwIjoxNzYwMDk2NzE0fQ._ACTOMkXU9L0EVvbT84N-6F-AYg7CB9P56Lv-aC34ak',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        _inspection = FormingInspection.fromJson(decoded);
      } else {
        _error = 'Failed to load inspection: ${response.statusCode}';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
