import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.kAccent4,
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
