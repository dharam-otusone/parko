import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parko/screens/home_screen.dart';
import 'package:parko/screens/signup_screen.dart';
import 'package:parko/screens/splash_screen.dart';
import 'package:parko/screens/staffonboardingscreen.dart';
import 'package:parko/screens/staffonboardingtwo.dart';

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/', // Start at the splash screen
    routes: [
      // Splash Screen route
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
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
    ],
  );
}
