import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parko/screens/assemblyline_inspectionform.dart';
import 'package:parko/screens/editprofilescreen.dart';
import 'package:parko/screens/home_screen.dart';
import 'package:parko/screens/incomig_inspection_report_form.dart';
import 'package:parko/screens/incoming_inspection.dart';
import 'package:parko/screens/inputfield.dart';
import 'package:parko/screens/inspectsummary.dart';
import 'package:parko/screens/newform.dart';
import 'package:parko/screens/profilescreen.dart';
import 'package:parko/screens/report_form.dart';
import 'package:parko/screens/signup_screen.dart';
import 'package:parko/screens/splash_screen.dart';
import 'package:parko/screens/staffonboardingscreen.dart';
import 'package:parko/screens/staffonboardingtwo.dart';
import 'package:parko/screens/surfacecoatinginspection.dart';
import 'package:parko/screens/update_password.dart';

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/', // Start at the splash screen
    routes: [
      // Splash Screen route
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return AssemblyLineInspectionForm();
        },
      ),

      // Home Screen route
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return SignInScreen();
        },
      ),
      GoRoute(
        path: '/staffonboarding',
        builder: (BuildContext context, GoRouterState state) {
          return StaffOnboardingScreen();
        },
      ),
      GoRoute(
        path: '/staffonboarding2',
        builder: (BuildContext context, GoRouterState state) {
          return StaffOnboardingStep2();
        },
      ),

      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return ProfileScreen();
        },
      ),
      GoRoute(
        path: '/editprofile',
        builder: (BuildContext context, GoRouterState state) {
          return EditProfileScreen();
        },
      ),
      GoRoute(
        path: '/updatepassword',
        builder: (BuildContext context, GoRouterState state) {
          return UpdatePasswordScreen();
        },
      ),
      GoRoute(
        path: '/newform',
        builder: (BuildContext context, GoRouterState state) {
          return NewFormScreen();
        },
      ),
      GoRoute(
        path: '/inpectionform',
        builder: (BuildContext context, GoRouterState state) {
          return IncomingInspectionForm();
        },
      ),
    ],
  );
}
