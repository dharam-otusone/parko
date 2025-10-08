import 'package:flutter/material.dart';
import 'package:parko/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _accessToken;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get accessToken => _accessToken;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.postRequest(
        '/login', // Adjust your endpoint
        {"email": email, "password": password},
      );

      // Assuming API returns: { "token": "xyz", "user": {...} }
      _accessToken = response['token'];
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _accessToken = null;
    notifyListeners();
  }
}
