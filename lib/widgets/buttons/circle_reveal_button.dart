import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';
import 'package:screening_sleep_apnea/widgets/buttons/custom_button.dart';

import '../../animations/circular_reveal_route.dart';

class CircleRevealButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget targetPage;
  final Color revealColor;
  final Color? buttonColor;
  final Color? textColor;
  final Widget child;

  const CircleRevealButton({super.key, required this.onPressed, required this.targetPage, required this.revealColor, required this.child, this.buttonColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: (){
          onPressed();

          // print("transition here");
          final RenderBox buttonBox = context.findRenderObject() as RenderBox;
          final Offset center = buttonBox.localToGlobal(buttonBox.size.center(Offset.zero));

          Navigator.of(context).pushReplacement(
            CircularRevealRoute(
              page: targetPage,
              center: center,
              color: revealColor,
            ),
          );
        },
        buttonColor: buttonColor ?? revealColor,
        textColor: textColor ?? Colors.white,
        child: child,
    );
  }
}