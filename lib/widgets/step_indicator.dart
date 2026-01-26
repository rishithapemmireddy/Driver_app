import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  /// The current step number (1 to 4)
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        // index starts at 0, so Step 1 corresponds to index 0
        bool isActive = index < currentStep;

        return Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              // Active steps use the Nexoryd Blue, others use light blue
              color: isActive ? const Color(0xFF154FB9) : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}