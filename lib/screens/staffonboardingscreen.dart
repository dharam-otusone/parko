import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StaffOnboardingScreen extends StatefulWidget {
  const StaffOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<StaffOnboardingScreen> createState() => _StaffOnboardingScreenState();
}

class _StaffOnboardingScreenState extends State<StaffOnboardingScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                "Staff Onboarding",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              Text(
                "Register to access the Quality Management\nSystem. create your own account",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Progress Indicator Row (1,2,3 steps)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStepCircle(context, "1", true),
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 2),
                  ),
                  _buildStepCircle(context, "2", true),
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 2),
                  ),
                  _buildStepCircle(context, "3", false),
                ],
              ),

              const SizedBox(height: 40),

              // Employee ID
              _buildInputField(
                controller: employeeIdController,
                label: "Employee ID*",
              ),
              const SizedBox(height: 20),

              // Username
              _buildInputField(
                controller: usernameController,
                label: "Username*",
              ),
              const SizedBox(height: 20),

              // Full Name
              _buildInputField(
                controller: fullNameController,
                label: "Full name*",
              ),
              const SizedBox(height: 20),

              // Email Address
              _buildInputField(
                controller: emailController,
                label: "Email Address*",
              ),

              SizedBox(height: size.height * 0.06),

              // Back & Next Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context.go('/staffonboarding2');
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Input Field Widget
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.red.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Step Circle Widget
  Widget _buildStepCircle(BuildContext context, String number, bool active) {
    return CircleAvatar(
      radius: 16,
      backgroundColor:
          active ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
      child: Text(number, style: const TextStyle(color: Colors.white)),
    );
  }
}
