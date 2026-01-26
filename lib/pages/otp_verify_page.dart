import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/logo_widget.dart';
import '../widgets/custom_keypad.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String otpCode = "";
  final FocusNode _keyboardNode = FocusNode();

  // Branding Colors
  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594); // Dark Blue
  final Color secondaryText = const Color(0xFF5E6D82);

  void _handleInput(String value) {
    if (otpCode.length < 4) {
      setState(() {
        otpCode += value;
      });
    }
  }

  void _handleBackspace() {
    if (otpCode.isNotEmpty) {
      setState(() {
        otpCode = otpCode.substring(0, otpCode.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Laptop keyboard support
      body: RawKeyboardListener(
        focusNode: _keyboardNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              _handleBackspace();
            }
            String? char = event.character;
            if (char != null && RegExp(r'^[0-9]$').hasMatch(char)) {
              _handleInput(char);
            }
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3],
              colors: [Color(0xFFF6F9FF), Colors.white],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // --- Top Bar: Back Button and Centered Logo ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(child: Center(child: LogoWidget(fontSize: 30))),
                      const SizedBox(width: 48), 
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Verify your mobile number",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "We have sent an OTP to your mobile number",
                          style: TextStyle(fontSize: 15, color: secondaryText),
                        ),
                        const SizedBox(height: 60),

                        // --- OTP Boxes ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            String char = "";
                            if (otpCode.length > index) char = otpCode[index];
                            bool isActive = otpCode.length == index;

                            return Container(
                              width: 65,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isActive ? logoBlue : Colors.grey.shade200,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                char,
                                style: const TextStyle(
                                  fontSize: 24, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 60),

                        // --- Resend link ---
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 15, color: Colors.black54),
                              children: [
                                const TextSpan(text: "Didn't receive code? "),
                                TextSpan(
                                  text: "Resend",
                                  style: TextStyle(color: logoBlue, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- Verify OTP Button (Always Active and Dark Blue) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Always clickable, goes to Profile Details
                        Navigator.pushNamed(context, '/profile_details');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlueButton, // Always dark blue
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Verify OTP",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                const FooterTermsText(),
                const SizedBox(height: 15),

                // --- Custom Keypad ---
                CustomKeypad(
                  onKeyPress: _handleInput,
                  onBackspace: _handleBackspace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FooterTermsText extends StatelessWidget {
  const FooterTermsText({super.key});
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text("By continuing, you agree to our ", style: TextStyle(fontSize: 12, color: Colors.black54)),
        Text("Terms of Service", style: TextStyle(fontSize: 12, color: Color(0xFF084594), decoration: TextDecoration.underline)),
        Text(" and ", style: TextStyle(fontSize: 12, color: Colors.black54)),
        Text("Privacy Policy", style: TextStyle(fontSize: 12, color: Color(0xFF084594), decoration: TextDecoration.underline)),
      ],
    );
  }
}