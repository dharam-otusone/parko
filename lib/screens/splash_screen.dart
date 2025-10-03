import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds before navigating to HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to HomeScreen after the delay
      context.go('/signup');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Optional: Set background color
      body: Center(
        child: Image.asset(
          'asset/images/parko_splash.png',
        ), // Your splash screen image
      ),
    );
  }
}
