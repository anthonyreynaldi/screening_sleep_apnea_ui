import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isEnabled;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.isEnabled = true,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.isEnabled;
  }

  @override
  void didUpdateWidget(CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled) {
      setState(() {
        _isEnabled = widget.isEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isEnabled ? widget.onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonColor ?? AppColors.kPrimary,
        disabledBackgroundColor: AppColors.kPrimaryColor[100],
        foregroundColor: widget.textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: widget.child
    );
  }
}
