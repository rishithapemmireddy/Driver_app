import 'package:flutter/material.dart';
import '../widgets/step_indicator.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class ProfileDetailsPageState {
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String selectedGender = "Male";

  // Branding Colors
  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);
  final Color scaffoldBg = const Color(0xFFF9FBFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Details",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Let's add your general details",
              style: TextStyle(color: secondaryText, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 20),
            child: Text(
              "Step 1 of 4",
              style: TextStyle(color: logoBlue, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // --- Step Progress Bar ---
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StepIndicator(currentStep: 1),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Full Name"),
                  _field(Icons.person_outline, "Enter your name"),
                  
                  _label("Email Address"),
                  _field(Icons.email_outlined, "Enter your email"),
                  
                  _label("Mobile Number"),
                  _field(Icons.phone_outlined, "Enter your mobile number"),
                  
                  _label("Gender"),
                  Row(
                    children: [
                      _genderBtn("Male"),
                      const SizedBox(width: 10),
                      _genderBtn("Female"),
                      const SizedBox(width: 10),
                      _genderBtn("Others"),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  _label("Address"),
                  _field(Icons.location_on_outlined, "Enter your address", isLarge: true),
                ],
              ),
            ),
          ),

          // --- Next Button ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/vehicle_details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlueButton,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Input Labels
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5E6D82)),
      ),
    );
  }

  // Helper Widget for Text Fields
  Widget _field(IconData icon, String hint, {bool isLarge = false}) {
    return TextField(
      maxLines: isLarge ? 3 : 1,
      cursorColor: logoBlue,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey, size: 22),
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: logoBlue, width: 1.5),
        ),
      ),
    );
  }

  // Helper Widget for Gender Selection Buttons
  Widget _genderBtn(String title) {
    bool isSelected = selectedGender == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedGender = title),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? logoBlue : Colors.grey.shade100,
              width: 1.5,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? logoBlue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}