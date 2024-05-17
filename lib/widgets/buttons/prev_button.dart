
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrevButton extends StatelessWidget {
  final VoidCallback onTap;
  const PrevButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.navigate_before),
          // Text("prev"),
        ],
      ),
    );
  }
}

