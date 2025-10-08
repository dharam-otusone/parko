// providers/username_provider.dart
import 'package:flutter/foundation.dart';
import 'package:parko/services/usernaameservice.dart';

class UsernameProvider with ChangeNotifier {
  final UsernameService _usernameService = UsernameService();

  bool _isLoading = false;
  String? _generatedUsername;
  String? _error;

  bool get isLoading => _isLoading;
  String? get generatedUsername => _generatedUsername;
  String? get error => _error;

  Future<void> generateUsername(String fullName) async {
    if (fullName.isEmpty) {
      _error = 'Please enter full name first';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    _generatedUsername = null;
    notifyListeners();

    try {
      final username = await _usernameService.generateUsername(fullName);
      _generatedUsername = username;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearGeneratedUsername() {
    _generatedUsername = null;
    _error = null;
    notifyListeners();
  }

  void setGeneratedUsername(String username) {
    _generatedUsername = username;
    notifyListeners();
  }
}
