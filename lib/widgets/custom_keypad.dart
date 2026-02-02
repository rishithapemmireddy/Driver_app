import 'package:flutter/material.dart';

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyPress;
  final VoidCallback onBackspace;

  const CustomKeypad({super.key, required this.onKeyPress, required this.onBackspace});

  Widget _buildKey(String label, String sub) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onKeyPress(label),
        child: Container(
          height: 55,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              if (sub.isNotEmpty)
                Text(sub, style: const TextStyle(fontSize: 9, color: Colors.black54, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD1D6DB),
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 25),
      child: Column(
        children: [
          Row(children: [_buildKey("1", ""), _buildKey("2", "A B C"), _buildKey("3", "D E F")]),
          Row(children: [_buildKey("4", "G H I"), _buildKey("5", "J K L"), _buildKey("6", "M N O")]),
          Row(children: [_buildKey("7", "P Q R S"), _buildKey("8", "T U V"), _buildKey("9", "W X Y Z")]),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              _buildKey("0", ""),
              Expanded(
                child: GestureDetector(
                  onTap: onBackspace,
                  child: const Icon(Icons.backspace_outlined, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}