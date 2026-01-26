import 'package:flutter/material.dart';

class VerificationPendingPage extends StatelessWidget {
  const VerificationPendingPage({super.key});

  // Branding Colors from your code
  final Color logoBlue = const Color(0xFF154FB9);
  final Color secondaryText = const Color(0xFF5E6D82);
  final Color scaffoldBg = const Color(0xFFF9FBFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Navigates to the main Home Dashboard (Root)
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Stack(
          children: [
            // --- Centered Status Card ---
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with background circle
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.access_time_filled,
                        size: 50,
                        color: logoBlue,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Verification Pending",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: logoBlue,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Your documents are under review. This usually takes 1-2 days.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: secondaryText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Branding Watermark at the Bottom ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Opacity(
                  opacity: 0.1,
                  child: Text(
                    "NEXORYD",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: Colors.blueGrey.shade900,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}