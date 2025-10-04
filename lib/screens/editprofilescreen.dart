import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Dropdown selections
  String? selectedRole;
  String? selectedDepartment;
  String? selectedShift;

  // Dropdown options
  final List<String> roles = [
    "Admin",
    "Quality Head",
    "Worker",
    "Supervisor",
    "Manager",
  ];

  final List<String> departments = [
    "Production",
    "Quality Control",
    "Job work",
    "Packing",
    "Dispatch",
  ];

  final List<String> shifts = ["Day", "Night", "Rotational"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                "Edit profile",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 50, 55, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Swati jha",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "@username",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        context.go('/updatepassword');
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Email
                    _infoRow(
                      title: "Email",
                      subtitle: "dummymail@gmail.com",
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.red),
                        onPressed: () {},
                      ),
                    ),

                    const Divider(),

                    // Role Dropdown
                    _dropdownRow(
                      title: "Role",
                      hint: "Select the role",
                      value: selectedRole,
                      items: roles,
                      onChanged: (val) {
                        setState(() => selectedRole = val);
                      },
                    ),

                    const Divider(),

                    // Department Dropdown
                    _dropdownRow(
                      title: "Department",
                      hint: "Select the Department",
                      value: selectedDepartment,
                      items: departments,
                      onChanged: (val) {
                        setState(() => selectedDepartment = val);
                      },
                    ),

                    const Divider(),

                    // Shifts Dropdown
                    _dropdownRow(
                      title: "Shifts",
                      hint: "Further secure your account for safety",
                      value: selectedShift,
                      items: shifts,
                      onChanged: (val) {
                        setState(() => selectedShift = val);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for email row with edit button
  Widget _infoRow({
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        trailing,
      ],
    );
  }

  // Widget for dropdown row
  Widget _dropdownRow({
    required String title,
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.black54)),
          isExpanded: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
