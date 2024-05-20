import 'dart:math';

import 'package:flutter/material.dart';

class CircularRevealRoute extends PageRouteBuilder {
  final Widget page;
  final Offset center;
  final Color color;

  CircularRevealRoute({
    required this.page,
    required this.center,
    required this.color,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: CircularRevealClipper(animation.value, center),
                  child: Container(
                    color: color,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  CircularRevealClipper(this.fraction, this.center);

  @override
  Path getClip(Size size) {
    // Calculate the radius to be 1.5 times the larger dimension (width or height)
    double maxDimension = size.width > size.height ? size.width : size.height;
    double radius = maxDimension * 1.5 * fraction;
    
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..close();
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) {
    return fraction != oldClipper.fraction || center != oldClipper.center;
  }
}