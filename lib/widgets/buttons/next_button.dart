
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  const NextButton({required this.onTap, super.key});

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
          // Text("next"),
          Icon(Icons.navigate_next),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.kPrimary, borderRadius: BorderRadius.circular(48)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Next"),
            const Icon(Icons.navigate_next, size: 30, color: Colors.white),
          ],
        )
      ),
    );
  }
}

