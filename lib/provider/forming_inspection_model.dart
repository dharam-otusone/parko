import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import 'dart:convert';
import '../models/inspection_model.dart';

class FormingInpectionProvider with ChangeNotifier {
  List<Inspection> _inspections = [];
  List<Inspection> _filtered = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<Inspection> get inspections => _filtered;

  Future<void> fetchInspections() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/forming-process-inspections'),
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MTRhMmRkOWZkYmM3M2JlNjk5NzMiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1ODgwMDcxNCwiZXhwIjoxNzYwMDk2NzE0fQ._ACTOMkXU9L0EVvbT84N-6F-AYg7CB9P56Lv-aC34ak',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];

        _inspections = data.map((e) => Inspection.fromJson(e)).toList();
        _filtered = List.from(_inspections);
      } else {
        throw Exception('Failed to fetch inspections');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterByInspector(String? inspectorName) {
    if (inspectorName == null ||
        inspectorName.isEmpty ||
        inspectorName == 'All') {
      _filtered = List.from(_inspections);
    } else {
      _filtered =
          _inspections
              .where(
                (e) =>
                    e.inspectorName.toLowerCase() ==
                    inspectorName.toLowerCase(),
              )
              .toList();
    }
    notifyListeners();
  }

  List<String> get inspectorNames {
    final names = _inspections.map((e) => e.inspectorName).toSet().toList();
    names.insert(0, 'All');
    return names;
  }
}
