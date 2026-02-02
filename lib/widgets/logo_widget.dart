import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double fontSize;
  const LogoWidget({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: fontSize, letterSpacing: 1.0),
        children: const [
          TextSpan(
            text: 'NEXO',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontFamily: 'serif'),
          ),
          TextSpan(
            text: 'RYD',
            style: TextStyle(color: Color(0xFF154FB9), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}