import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:parko/models/user_modal.dart';
import 'package:parko/services/auth_service.dart';
import 'package:parko/services/storage_services.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.postRequest(
        // adjust endpoint
        {"email": email, "password": password},
      );

      if (response['success'] == true) {
        final data = response['data'];
        final userData = data['user'];
        final tokens = data['tokens'];

        _user = UserModel.fromJson(userData);

        await _storageService.saveToken(
          tokens['accessToken'],
          tokens['refreshToken'],
        );

        log('✅ Login successful: ${_user!.email}');
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.clear();
    _user = null;
    notifyListeners();
  }

  Future<void> loadUserFromStorage() async {
    final token = await _storageService.getAccessToken();
    if (token != null) {
      // Optional: Verify token or fetch user details
      log('User session restored from token');
    }
  }
}
