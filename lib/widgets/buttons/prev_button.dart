
import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/widgets/buttons/custom_button.dart';

import '../../utils/app_colors.dart';

class PrevButton extends StatefulWidget {
  final VoidCallback onTap;
  bool isEnable;

  PrevButton({required this.onTap, this.isEnable = true, super.key});

  @override
  State<PrevButton> createState() => _PrevButtonState();
}

class _PrevButtonState extends State<PrevButton> {

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: widget.onTap,
      isEnabled: widget.isEnable,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.navigate_before),
        ],
      ),
    );
  }
}

