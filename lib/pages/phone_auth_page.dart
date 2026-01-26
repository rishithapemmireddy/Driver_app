import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/logo_widget.dart';
import '../widgets/custom_keypad.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  String phoneNumber = "";
  bool isFocused = true; // To show the cursor
  final FocusNode _keyboardNode = FocusNode();

  // Branding Colors
  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);

  void _handleInput(String value) {
    if (phoneNumber.length < 10) {
      setState(() {
        phoneNumber += value;
      });
    }
  }

  void _handleBackspace() {
    if (phoneNumber.isNotEmpty) {
      setState(() {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Center(child: LogoWidget(fontSize: 34)),
                        const SizedBox(height: 60),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Enter your mobile number to continue",
                          style: TextStyle(fontSize: 15, color: secondaryText),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "Mobile Number",
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        GestureDetector(
                          onTap: () => _keyboardNode.requestFocus(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: logoBlue, width: 1.8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.phone_outlined, color: secondaryText, size: 22),
                                const SizedBox(width: 12),
                                const Text("+91",
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 10),
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    if (phoneNumber.isEmpty)
                                      Text(
                                        "Enter 10 digit mobile number",
                                        style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                                      ),
                                    Row(
                                      children: [
                                        Text(
                                          phoneNumber,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            letterSpacing: 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (phoneNumber.length < 10)
                                          const Padding(
                                            padding: EdgeInsets.only(left: 2),
                                            child: StaticCursor(),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // --- Send OTP Button (Always Blue and Always Clickable) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Always navigates regardless of input length
                        Navigator.pushNamed(context, '/otp_verify');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlueButton, // Full blue color
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                const FooterTermsText(),
                const SizedBox(height: 15),
                
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

class StaticCursor extends StatefulWidget {
  const StaticCursor({super.key});

  @override
  State<StaticCursor> createState() => _StaticCursorState();
}

class _StaticCursorState extends State<StaticCursor> {
  bool _visible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) setState(() => _visible = !_visible);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _visible ? 1.0 : 0.0,
      child: Container(width: 2, height: 22, color: const Color(0xFF154FB9)),
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