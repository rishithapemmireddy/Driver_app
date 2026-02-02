import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../widgets/logo_widget.dart';
import '../widgets/custom_keypad.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String otpCode = "";
  bool _isVerifying = false; 
  bool _isKeypadVisible = false; // Visibility state for CustomKeypad
  final FocusNode _keyboardNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Color logoBlue = const Color(0xFF154FB9);
  final Color darkBlueButton = const Color(0xFF084594);
  final Color secondaryText = const Color(0xFF5E6D82);

  @override
  void initState() {
    super.initState();
    _keyboardNode.addListener(() {
      if (_keyboardNode.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    });
  }

  @override
  void dispose() {
    _keyboardNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp(dynamic authData) async {
    if (_isVerifying) return;

    if (otpCode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the full 6-digit OTP")),
      );
      return;
    }

    setState(() {
      _isVerifying = true;
      _isKeypadVisible = false; // Hide keypad during verification
    });

    try {
      if (kIsWeb && authData is ConfirmationResult) {
        await authData.confirm(otpCode);
      } else if (authData is String) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: authData,
          smsCode: otpCode,
        );
        await _auth.signInWithCredential(credential);
      } else {
        throw "Authentication session lost. Please go back and try again.";
      }
      
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/profile_details', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _isVerifying = false);
      String errorMessage = "Invalid OTP. Please try again.";
      if (e.code == 'session-expired') errorMessage = "OTP session expired. Please resend.";
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      setState(() => _isVerifying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred.")),
      );
    }
  }

  void _handleInput(String value) {
    if (otpCode.length < 6) { 
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
    final dynamic authData = ModalRoute.of(context)!.settings.arguments;

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
                          "Enter the 6-digit code sent to your device",
                          style: TextStyle(fontSize: 15, color: secondaryText),
                        ),
                        const SizedBox(height: 60),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isKeypadVisible = true; // Show keypad on box tap
                            });
                            _keyboardNode.requestFocus();
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              String char = "";
                              if (otpCode.length > index) char = otpCode[index];
                              bool isActive = otpCode.length == index;

                              return Container(
                                width: 45,
                                height: 60,
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
                                    fontSize: 22, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 60),

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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isVerifying ? null : () => _verifyOtp(authData),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlueButton,
                        disabledBackgroundColor: darkBlueButton.withOpacity(0.6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: _isVerifying 
                        ? const SizedBox(
                            height: 24, 
                            width: 24, 
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          )
                        : const Text(
                            "Verify OTP",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                const FooterTermsText(),
                const SizedBox(height: 15),

                // Conditionally show custom keypad
                if (_isKeypadVisible)
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