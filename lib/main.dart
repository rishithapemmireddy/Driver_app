import 'package:flutter/material.dart';
// Ensure these paths match your actual folder structure
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

void main() {
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
        // Nexoryd Professional Blue Theme
        primaryColor: const Color(0xFF154FB9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF154FB9),
          primary: const Color(0xFF154FB9),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FB),
        useMaterial3: true,
      ),
      // Define the starting page
      initialRoute: '/',
      // Navigation Routes
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