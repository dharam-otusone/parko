import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import 'package:parko/models/inspection_model.dart';

class InspectionProvider with ChangeNotifier {
  List<Inspection> _allInspections = [];
  List<Inspection> _filteredInspections = [];
  String _selectedInspector = 'All';

  List<Inspection> get inspections => _filteredInspections;
  String get selectedInspector => _selectedInspector;

  Future<void> fetchInspections() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/inspections'),
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MTRhMmRkOWZkYmM3M2JlNjk5NzMiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1ODgwMDcxNCwiZXhwIjoxNzYwMDk2NzE0fQ._ACTOMkXU9L0EVvbT84N-6F-AYg7CB9P56Lv-aC34ak',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded['data'] is List) {
          final List<dynamic> jsonData = decoded['data'];
          _allInspections =
              jsonData.map((e) => Inspection.fromJson(e)).toList();
          _filteredInspections = List.from(_allInspections);
          notifyListeners();
        } else {
          throw Exception('Unexpected response structure');
        }
      } else {
        throw Exception('Failed to load inspections');
      }
    } catch (e) {
      debugPrint('Error fetching inspections: $e');
    }
  }

  void filterByInspector(String name) {
    _selectedInspector = name;
    if (name == 'All') {
      _filteredInspections = List.from(_allInspections);
    } else {
      _filteredInspections =
          _allInspections
              .where(
                (insp) => insp.inspectorName.toLowerCase().contains(
                  name.toLowerCase(),
                ),
              )
              .toList();
    }
    notifyListeners();
  }

  List<String> get allInspectors {
    final inspectors =
        _allInspections.map((e) => e.inspectorName).toSet().toList();
    inspectors.sort();
    return ['All', ...inspectors];
  }
}
