import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// Helper functions to lighten or darken a color
Color lighten(Color color, {double factor = 0.1}) {
  final hsl = HSLColor.fromColor(color);
  final newLightness = math.max(0.0, hsl.lightness + factor);
  return HSLColor.fromAHSL(hsl.alpha, hsl.hue, newLightness, hsl.saturation).toColor();
}

Color slightlyDarken(Color color) {
  return darken(color, factor: 0.05); // Adjust factor for desired darkness
}

Color darken(Color color, {double factor = 0.1}) {
  final hsl = HSLColor.fromColor(color);
  final newLightness = math.min(1.0, hsl.lightness - factor);
  return HSLColor.fromAHSL(hsl.alpha, hsl.hue, newLightness, hsl.saturation).toColor();
}

// Create a very dark shade (adjust as needed)
Color veryDarken(Color color) {
  return darken(darken(color));
}

class AppColors {
  static const Color kPrimary = Color(0xFF6759FF);
  static const Color kBackground = Color(0xFFF9F9F9);
  static const Color kHint = Color(0xFFD1D3D4);
  static const Color kAccent4 = Color(0xFFB5EBCD);
  static const Color kAccent5 = Color(0xFF4E6157);

  // static MaterialColor kPrimaryColor =  MaterialColor(AppColors.kPrimary.value, <int, Color>{500: AppColors.kPrimary});
  static MaterialColor kPrimaryColor =  MaterialColor(
    AppColors.kPrimary.value,
    <int, Color>{
      50: Color(0xFFE5E1FF),  // 10%
      100: Color(0xFFC8BDFF), // 20%
      200: Color(0xFFAA98FF), // 30%
      300: Color(0xFF8C74FF), // 40%
      400: Color(0xFF755BFF), // 50%
      500: Color(0xFF6759FF), // 60%
      600: Color(0xFF5F51FF), // 70%
      700: Color(0xFF5446FF), // 80%
      800: Color(0xFF4A3CFF), // 90%
      900: Color(0xFF3929FF), // 100%
    },
  );
}

