import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DropdownScreen extends StatefulWidget {
  const DropdownScreen({super.key});

  @override
  State<DropdownScreen> createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  // Dropdown values
  String? selectedRole;
  String? selectedDepartment;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 100.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Choose the Role
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Choose the Role",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                value: selectedRole,
                items:
                    roles
                        .map(
                          (role) =>
                              DropdownMenuItem(value: role, child: Text(role)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Choose the Department
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Choose the Department",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                value: selectedDepartment,
                items:
                    departments
                        .map(
                          (dept) =>
                              DropdownMenuItem(value: dept, child: Text(dept)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.go('/signup');
              },
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
