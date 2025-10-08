// providers/staff_onboarding_provider.dart
import 'package:flutter/foundation.dart';
import 'package:parko/services/staffonbopard_service.dart';

class StaffOnboardingProvider with ChangeNotifier {
  final StaffOnboardingService _staffOnboardingService =
      StaffOnboardingService();

  bool _isSubmitting = false;
  String? _submitError;
  String? _submitSuccess;

  bool get isSubmitting => _isSubmitting;
  String? get submitError => _submitError;
  String? get submitSuccess => _submitSuccess;

  Future<Map<String, dynamic>> submitStaffOnboarding({
    required String employeeId,
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String role,
    required String department,
    String? mobile,
    String? shift,
    List<String>? assignedProcesses,
  }) async {
    _isSubmitting = true;
    _submitError = null;
    _submitSuccess = null;
    notifyListeners();

    try {
      // Prepare the request body according to your API
      final Map<String, dynamic> requestBody = {
        'employeeId': employeeId,
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
        'role': role.toLowerCase(), // Convert to lowercase as per your API
        'department': department,
        'mobile': mobile ?? '',
        'shifts': shift ?? 'day', // Default to 'day' if not provided
        'assignedProcesses': assignedProcesses ?? [],
      };

      final result = await _staffOnboardingService.createStaff(requestBody);

      if (result['success'] == true) {
        _submitSuccess = result['message'];
        _isSubmitting = false;
        notifyListeners();
        return {'success': true, 'data': result['data']};
      } else {
        _submitError = result['message'];
        _isSubmitting = false;
        notifyListeners();
        return {'success': false, 'message': result['message']};
      }
    } catch (e) {
      _submitError = e.toString();
      _isSubmitting = false;
      notifyListeners();
      return {'success': false, 'message': e.toString()};
    }
  }

  void clearSubmitState() {
    _submitError = null;
    _submitSuccess = null;
    notifyListeners();
  }
}
