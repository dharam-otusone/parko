import 'package:flutter/material.dart';

class StaffOnboardingStep2 extends StatefulWidget {
  const StaffOnboardingStep2({Key? key}) : super(key: key);

  @override
  State<StaffOnboardingStep2> createState() => _StaffOnboardingStep2State();
}

class _StaffOnboardingStep2State extends State<StaffOnboardingStep2> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? selectedRole;
  String? selectedDepartment;

  final List<String> roles = ["Manager", "Staff", "Intern"];
  final List<String> departments = ["HR", "Finance", "IT", "Operations"];

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

              // Password
              _buildPasswordField(
                controller: passwordController,
                label: "Password*",
                obscureText: _obscurePassword,
                toggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password
              _buildPasswordField(
                controller: confirmPasswordController,
                label: "Confirm Password*",
                obscureText: _obscureConfirmPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Role Dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Role",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildDropdown(
                value: selectedRole,
                hint: "Choose the role",
                items: roles,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Department Dropdown
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Department",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              _buildDropdown(
                value: selectedDepartment,
                hint: "Choose the Department",
                items: departments,
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
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
                      onPressed: () {},
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

  // Password Field Widget
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.red.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  // Dropdown Widget
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        underline: const SizedBox(),
        items:
            items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
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
