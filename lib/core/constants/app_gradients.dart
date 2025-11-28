import 'package:flutter/material.dart';

/// Gradient definitions from the design system
class AppGradients {
  /// Gradient: Dark blue to medium purple (horizontal)
  /// From #1A00D2 (dark blue) to #7464E4 (medium purple)
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1A00D2), // Dark blue
      Color(0xFF7464E4), // Medium purple
    ],
  );

  /// Gradient2: Bright cyan to vibrant green (horizontal)
  /// From cyan to #3CBD53 (green)
  static const LinearGradient gradient2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF00BCD4), // Bright cyan
      Color(0xFF3CBD53), // Vibrant green
    ],
  );

  /// Helper method to create a gradient box decoration
  static BoxDecoration gradientBoxDecoration({
    required LinearGradient gradient,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(gradient: gradient, borderRadius: borderRadius);
  }

  /// Helper method to create a gradient container
  static Widget gradientContainer({
    required LinearGradient gradient,
    required Widget child,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: gradientBoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
