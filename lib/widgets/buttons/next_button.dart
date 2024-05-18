
import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/widgets/buttons/custom_button.dart';

import '../../utils/app_colors.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onTap;
  bool isEnable;

  NextButton({required this.onTap, this.isEnable = true, super.key});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: widget.onTap,
      isEnabled: widget.isEnable,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }
}

