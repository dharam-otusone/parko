import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parko/provider/staffonboarding_provider.dart';
import 'package:parko/provider/usernameprovider.dart';
import 'package:provider/provider.dart';

class StaffOnboardingScreen extends StatefulWidget {
  const StaffOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<StaffOnboardingScreen> createState() => _StaffOnboardingScreenState();
}

class _StaffOnboardingScreenState extends State<StaffOnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1 Controllers
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  // Step 2 Controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? selectedRole;
  String? selectedDepartment;
  String? selectedShift;

  final List<String> roles = ["Manager", "Staff", "Intern"];
  final List<String> departments = [
    "Operations",
    "QC",
    "Production",
    "Job Work",
    "Packing",
    "Dispatch",
  ];
  final List<String> shifts = ["day", "night", "custom"];

  // Store provider references in initState
  late UsernameProvider _usernameProvider;
  late StaffOnboardingProvider _staffOnboardingProvider;

  @override
  void initState() {
    super.initState();

    // Get the provider instances in initState
    _usernameProvider = Provider.of<UsernameProvider>(context, listen: false);
    _staffOnboardingProvider = Provider.of<StaffOnboardingProvider>(
      context,
      listen: false,
    );

    // Listen to full name changes to clear generated username
    fullNameController.addListener(_onFullNameChanged);

    // Listen to provider changes
    _usernameProvider.addListener(_onUsernameGenerated);
  }

  void _onFullNameChanged() {
    // Clear generated username when full name changes
    if (_usernameProvider.generatedUsername != null) {
      _usernameProvider.clearGeneratedUsername();
    }
  }

  void _onUsernameGenerated() {
    if (_usernameProvider.generatedUsername != null && mounted) {
      // Auto-fill the username field
      usernameController.text = _usernameProvider.generatedUsername!;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Username generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (_usernameProvider.error != null && mounted) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_usernameProvider.error!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Remove listeners before disposing
    fullNameController.removeListener(_onFullNameChanged);
    _usernameProvider.removeListener(_onUsernameGenerated);

    _pageController.dispose();
    employeeIdController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _generateUsername() {
    final fullName = fullNameController.text.trim();
    if (fullName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter full name first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _usernameProvider.generateUsername(fullName);
  }

  Future<void> _submitForm() async {
    // Validate all fields
    if (employeeIdController.text.isEmpty ||
        usernameController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedRole == null ||
        selectedDepartment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Submit the form
    final result = await _staffOnboardingProvider.submitStaffOnboarding(
      employeeId: employeeIdController.text.trim(),
      fullName: fullNameController.text.trim(),
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      role: selectedRole!,
      department: selectedDepartment!,
      mobile:
          mobileController.text.trim().isNotEmpty
              ? mobileController.text.trim()
              : null,
      shift: selectedShift,
      assignedProcesses: [], // You can modify this as needed
    );

    if (result['success'] == true && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _staffOnboardingProvider.submitSuccess ??
                'Staff created successfully!',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // Navigate to next screen or reset form
      _resetForm();
      context.go('/staff-list'); // Navigate to staff list or dashboard
    } else if (mounted) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _staffOnboardingProvider.submitError ?? 'Failed to create staff',
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _currentStep = 0;
      employeeIdController.clear();
      usernameController.clear();
      fullNameController.clear();
      emailController.clear();
      mobileController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      selectedRole = null;
      selectedDepartment = null;
      selectedShift = null;
    });
    _pageController.jumpToPage(0);
    _usernameProvider.clearGeneratedUsername();
    _staffOnboardingProvider.clearSubmitState();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      // Validate Step 1
      if (employeeIdController.text.isEmpty ||
          usernameController.text.isEmpty ||
          fullNameController.text.isEmpty ||
          emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all required fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() => _currentStep = 1);
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentStep == 1) {
      // Submit the form
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep = _currentStep - 1);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section (Fixed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  // Title
                  Text(
                    "Staff Onboarding",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Register to access the Quality Management\nSystem. Create your own account",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // Progress Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStepCircle(context, "1", _currentStep >= 0),
                      Container(
                        width: 60,
                        height: 2,
                        color:
                            _currentStep >= 1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade400,
                      ),
                      _buildStepCircle(context, "2", _currentStep >= 1),
                    ],
                  ),
                ],
              ),
            ),

            // Form Content (Scrollable)
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentStep = index);
                  },
                  children: [
                    // Step 1: Basic Information
                    _buildStep1(),

                    // Step 2: Password and Role
                    _buildStep2(),
                  ],
                ),
              ),
            ),

            // Bottom Buttons (Fixed)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<StaffOnboardingProvider>(
                builder: (context, staffOnboardingProvider, child) {
                  return Row(
                    children: [
                      if (_currentStep > 0)
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
                            onPressed:
                                staffOnboardingProvider.isSubmitting
                                    ? null
                                    : _previousStep,
                            child: Text(
                              "Back",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (_currentStep > 0) const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed:
                              staffOnboardingProvider.isSubmitting
                                  ? null
                                  : _nextStep,
                          child:
                              staffOnboardingProvider.isSubmitting
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Text(
                                    _currentStep == 1 ? "Submit" : "Next",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1: Basic Information
  Widget _buildStep1() {
    return Consumer<UsernameProvider>(
      builder: (context, usernameProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                "Basic Information",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please provide your basic details",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Employee ID
              _buildInputField(
                controller: employeeIdController,
                label: "Employee ID*",
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 20),

              // Full Name with Generate Username button
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name*",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.red.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            hintText: "Enter your full name",
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed:
                              usernameProvider.isLoading
                                  ? null
                                  : _generateUsername,
                          child:
                              usernameProvider.isLoading
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : const Text(
                                    'Generate',
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
              const SizedBox(height: 20),

              // Username
              _buildInputField(
                controller: usernameController,
                label: "Username*",
                icon: Icons.person_outline,
                readOnly: usernameProvider.generatedUsername != null,
              ),
              const SizedBox(height: 20),

              // Email Address
              _buildInputField(
                controller: emailController,
                label: "Email Address*",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Mobile Number (Optional)
              _buildInputField(
                controller: mobileController,
                label: "Mobile Number",
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  // Step 2: Password and Role
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "Security & Role",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Set your password and select your role",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 30),

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
          Text(
            "Role*",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdown(
            value: selectedRole,
            hint: "Choose the role",
            items: roles,
            icon: Icons.work_outline,
            onChanged: (value) {
              setState(() {
                selectedRole = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Department Dropdown
          Text(
            "Department*",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdown(
            value: selectedDepartment,
            hint: "Choose the Department",
            items: departments,
            icon: Icons.business_outlined,
            onChanged: (value) {
              setState(() {
                selectedDepartment = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Shift Dropdown (Optional)
          Text(
            "Shift",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdown(
            value: selectedShift,
            hint: "Choose the Shift",
            items: shifts,
            icon: Icons.schedule_outlined,
            onChanged: (value) {
              setState(() {
                selectedShift = value;
              });
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Updated Input Field Widget with readOnly parameter
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        filled: true,
        fillColor: readOnly ? Colors.grey.shade200 : Colors.red.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
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
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        filled: true,
        fillColor: Colors.red.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
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
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        ),
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
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            active
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade400,
        boxShadow:
            active
                ? [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [],
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
