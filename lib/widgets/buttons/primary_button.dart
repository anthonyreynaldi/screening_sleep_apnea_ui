

import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final bool isBorder;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.isBorder = false,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      alignment: Alignment.center,
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: isBorder ? Border.all(color: AppColors.kHint) : null),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize ?? 15,
        ),
      ),
    );
  }
}
