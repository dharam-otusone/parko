import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parko/constants/base_url.dart';
import '../models/surface_coating_model.dart';

class SurfaceCoatingProvider extends ChangeNotifier {
  List<SurfaceCoating> _inspections = [];
  List<SurfaceCoating> get inspections => _inspections;

  bool _isLoading = false;
  String? _error;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSurfaceCoatingInspections() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/surface-coating-inspections'),
        headers: {
          'Content-Type': 'application/json',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2OGQ1MTRhMmRkOWZkYmM3M2JlNjk5NzMiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc1ODgwMDcxNCwiZXhwIjoxNzYwMDk2NzE0fQ._ACTOMkXU9L0EVvbT84N-6F-AYg7CB9P56Lv-aC34ak',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List<dynamic> dataList = decoded['data'];
        _inspections = dataList.map((e) => SurfaceCoating.fromJson(e)).toList();
      } else {
        _error = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // 🔍 Filter by Inspector Name
  void filterByInspector(String name) {
    if (name.isEmpty) {
      fetchSurfaceCoatingInspections();
    } else {
      _inspections =
          _inspections
              .where(
                (e) =>
                    e.inspectorName.toLowerCase().contains(name.toLowerCase()),
              )
              .toList();
      notifyListeners();
    }
  }
}
