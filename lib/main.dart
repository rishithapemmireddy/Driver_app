import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Page Imports
import 'pages/splash_screen.dart';
import 'pages/phone_auth_page.dart';
import 'pages/otp_verify_page.dart';
import 'pages/profile_details_page.dart';
import 'pages/vehicle_details_page.dart';
import 'pages/profile_photo_page.dart';
import 'pages/upload_documents_page.dart';
import 'pages/verification_pending_page.dart';
import 'pages/home_dashboard.dart';
import 'pages/trip_details_page.dart';

Future<void> main() async {
  // Ensure Flutter framework is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Web / Android / iOS / Windows)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexoryd Driver',
      theme: ThemeData(
        primaryColor: const Color(0xFF154FB9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF154FB9),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FB),
        useMaterial3: true,
      ),

      // Initial Route
      initialRoute: '/',

      // Routes
      routes: {
        '/': (context) => const SplashScreen(),
        '/phone_auth': (context) => const PhoneAuthPage(),
        '/otp_verify': (context) => const OtpVerifyPage(),
        '/profile_details': (context) => const ProfileDetailsPage(),
        '/vehicle_details': (context) => const VehicleDetailsPage(),
        '/profile_photo': (context) => const ProfilePhotoPage(),
        '/upload_docs': (context) => const UploadDocumentsPage(),
        '/pending': (context) => const VerificationPendingPage(),
        '/home': (context) => const HomeDashboard(),
        '/trip_details': (context) => const TripDetailsPage(),
      },
    );
  }
}
