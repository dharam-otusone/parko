class UserModel {
  final String id;
  final String employeeId;
  final String username;
  final String email;
  final String role;
  final String department;

  UserModel({
    required this.id,
    required this.employeeId,
    required this.username,
    required this.email,
    required this.role,
    required this.department,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      employeeId: json['employeeId'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
