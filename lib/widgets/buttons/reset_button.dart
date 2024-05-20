import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';
import 'package:screening_sleep_apnea/widgets/buttons/circle_reveal_button.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget targetPage;
  const ResetButton({super.key, required this.onPressed, required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return CircleRevealButton(
      onPressed: onPressed, 
      targetPage: targetPage,
      revealColor: AppColors.kBackground,
      textColor: AppColors.kPrimary,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.replay_rounded),
          SizedBox(width: 8.0,),
          Text("RESET"),
        ],
      ),
    );
  }
}