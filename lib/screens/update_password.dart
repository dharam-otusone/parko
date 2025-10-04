import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 20),

              // Lock Illustration
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('asset/images/Lock-locked.png'),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Center(
                child: Text(
                  "Update Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle / Description
              const Center(
                child: Text(
                  "It was popularised in the 1960s with the release of\nLetraset sheets containing Lorem Ipsum.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),

              const SizedBox(height: 30),

              // Employee ID Field
              TextField(
                controller: employeeIdController,
                decoration: InputDecoration(
                  focusColor: Color.fromRGBO(253, 236, 235, 1),
                  fillColor: Color.fromRGBO(253, 236, 235, 1),
                  labelText: "Employee ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
              ),

              const SizedBox(height: 20),

              // New Password Field
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    context.go('/newform');
                    setState(() => isSubmitting = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() => isSubmitting = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password Updated")),
                      );
                    });
                  },
                  child:
                      isSubmitting
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Submitting...",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                          : const Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
