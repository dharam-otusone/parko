import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parko/provider/auth_provider.dart';
import 'package:parko/provider/forming_inspection_model.dart';
import 'package:parko/provider/forming_inspection_provider.dart';
import 'package:parko/provider/inspection_detail_provider.dart';
import 'package:parko/provider/inspection_provider.dart';
import 'package:parko/provider/staffonboarding_provider.dart';
import 'package:parko/provider/surface_coating_model.dart';
import 'package:parko/provider/usernameprovider.dart';

import 'package:parko/screens/admin/splash_screen.dart';
import 'package:parko/utils/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormingInpectionDetailProvider()),
        ChangeNotifierProvider(create: (_) => FormingInpectionProvider()),
        ChangeNotifierProvider(create: (_) => SurfaceCoatingProvider()),
        ChangeNotifierProvider(create: (_) => InspectionDetailProvider()),
        ChangeNotifierProvider(create: (_) => InspectionProvider()),
        ChangeNotifierProvider(create: (context) => StaffOnboardingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UsernameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter router = setupRouter();
    return MaterialApp.router(
      title: 'Parko',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFEC3237),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC3237),
          primary: const Color(0xFFEC3237),
          secondary: const Color(0xFFEC3237),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFEC3237)),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(
            color: Color(0xFFEC3237),
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true, // Enables modern Material theming
      ),
      routerConfig: router,
    );
  }
}
