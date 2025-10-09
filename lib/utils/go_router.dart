import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parko/screens/admin/all_inspection.dart';
import 'package:parko/screens/admin/assemblyline_inspectionform.dart';
import 'package:parko/screens/admin/batchdetailscreen.dart';
import 'package:parko/screens/admin/editprofilescreen.dart';
import 'package:parko/screens/admin/forming_inspection.dart';
import 'package:parko/screens/admin/forminginspection.dart';
import 'package:parko/screens/admin/home_screen.dart';
import 'package:parko/screens/admin/incomig_inspection_report_form.dart';
import 'package:parko/screens/admin/incoming_inspection.dart';
import 'package:parko/screens/admin/inputfield.dart';
import 'package:parko/screens/admin/inspection_detail_screen.dart';
import 'package:parko/screens/admin/inspectsummary.dart';
import 'package:parko/screens/admin/newform.dart';
import 'package:parko/screens/admin/pdir.dart';
import 'package:parko/screens/admin/profilescreen.dart';
import 'package:parko/screens/admin/qcparameter.dart';
import 'package:parko/screens/admin/report_form.dart';
import 'package:parko/screens/admin/signup_screen.dart';
import 'package:parko/screens/admin/splash_screen.dart';
import 'package:parko/screens/admin/staffonboardingscreen.dart';
import 'package:parko/screens/admin/staffonboardingtwo.dart';
import 'package:parko/screens/admin/staffperfomanceanalytics.dart';
import 'package:parko/screens/admin/stampinginspectionscreen.dart';
import 'package:parko/screens/admin/surface_coating_screen.dart';
import 'package:parko/screens/admin/surfacecoatinginspection.dart';
import 'package:parko/screens/admin/update_password.dart';

GoRouter setupRouter() {
  return GoRouter(
    initialLocation: '/', // Start at the splash screen
    routes: [
      // Splash Screen
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),

      // Auth routes
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/signup', builder: (context, state) => SignInScreen()),

      // Dashboard
      GoRoute(
        path: '/dashboard/overview',
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: '/dashboard/insights',
        builder: (context, state) => Placeholder(),
      ),

      // Supplier Management
      GoRoute(
        path: '/dashboard/suppliers/all',
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: '/dashboard/suppliers/add',
        builder: (context, state) => Placeholder(),
      ),

      // Onboarding
      GoRoute(
        path: '/dashboard/staffonboardscreen',
        builder: (context, state) => StaffOnboardingScreen(),
      ),

      // Profile
      GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
      GoRoute(
        path: '/editprofile',
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        path: '/updatepassword',
        builder: (context, state) => UpdatePasswordScreen(),
      ),

      // Form creation & listings
      GoRoute(path: '/newform', builder: (context, state) => NewFormScreen()),

      /// ---------------- INSPECTION ROUTES ----------------

      // Incoming Inspection
      GoRoute(
        path: '/dashboard/incominginspection/create',
        builder: (context, state) => IncomingInspectionForm(),
      ),
      GoRoute(
        path: '/dashboard/incominginspection/all',
        builder: (context, state) => InspectionScreen(),
      ),

      // Forming Process
      GoRoute(
        path: '/dashboard/forminginspection/create',
        builder: (context, state) => FormingInspectionReportForm(),
      ),
      GoRoute(
        path: '/dashboard/forminginspection/all',
        builder: (context, state) => InspectionListScreen(),
      ),

      // Surface Coating
      GoRoute(
        path: '/dashboard/surfacecoating/create',
        builder: (context, state) => SurfaceCoatingInspection(),
      ),
      GoRoute(
        path: '/dashboard/surfacecoating/all',
        builder: (context, state) => SurfaceCoatingListScreen(),
      ),

      // Assembly Line
      GoRoute(
        path: '/dashboard/assemblyline/create',
        builder: (context, state) => AssemblyLineInspectionForm(),
      ),
      GoRoute(
        path: '/dashboard/assemblyline/all',
        builder: (context, state) => Placeholder(),
      ),

      // Stamping
      GoRoute(
        path: '/dashboard/stamping/create',
        builder: (context, state) => StampingInspectionScreen(),
      ),
      GoRoute(
        path: '/dashboard/stamping/all',
        builder: (context, state) => Placeholder(),
      ),

      // Packaging
      GoRoute(
        path: '/dashboard/packaging/create',
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: '/dashboard/packaging/all',
        builder: (context, state) => Placeholder(),
      ),

      // Final PDIR
      GoRoute(
        path: '/dashboard/finalpdir/create',
        builder: (context, state) => PDIRScreen(),
      ),
      GoRoute(
        path: '/dashboard/finalpdir/all',
        builder: (context, state) => Placeholder(),
      ),

      // QC Parameters
      GoRoute(
        path: '/dashboard/qcparameter/create',
        builder: (context, state) => QcParametersScreen(),
      ),
      GoRoute(
        path: '/dashboard/qcparameter/all',
        builder: (context, state) => Placeholder(),
      ),
      GoRoute(
        path: '/inspection/:id',
        builder: (context, state) {
          final inspectionId = state.pathParameters['id']!;
          return InspectionDetailScreen(inspectionId: inspectionId);
        },
      ),
    ],
  );
}
