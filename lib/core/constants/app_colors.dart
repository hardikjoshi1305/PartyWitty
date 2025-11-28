import 'package:flutter/material.dart';

/// App-wide color constants matching the design system
class AppColors {
  // Primary Colors (from design system)
  static const Color primary = Color(0xFF7464E4); // Main purple
  static const Color primaryPurple = Color(
    0xFF7464E4,
  ); // Alias for backward compatibility
  static const Color primaryPurpleLight = Color(0xFF7C56CA);
  static const Color primaryPurpleDark = Color(0xFF6020E0);

  // Secondary Colors (from design system)
  static const Color secondary = Color(0xFF1A00D2); // Dark blue
  static const Color accentBlue = Color(
    0xFF1A00D2,
  ); // Alias for backward compatibility

  // Base Colors (from design system)
  static const Color black = Color(0xFF070707);
  static const Color gray = Color(0xFF4F4F4F);
  static const Color green = Color(0xFF3CBD53);
  static const Color red = Color(0xFFFF5C5C);
  static const Color pink = Color(0xFFFF3399);
  static const Color lightPink = Color(0x1AFF3399); // #FF33991A with alpha
  static const Color white = Color(0xB3FFFFFF); // #Ffffffb3 with alpha
  static const Color lightGray = Color(0xFFECECE9);

  // Accent Colors (additional)
  static const Color accentGreen = Color(
    0xFF3CBD53,
  ); // Using design system green
  static const Color accentYellow = Color(0xFFFFC107);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color backgroundGreyDarker = Color(0xFFD6D3D3);
  static const Color backgroundLightGrey = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(
    0xFF121212,
  );
  static const Color backgroundDarkTransperant = Color(
    0xA1393636,
  );
  // Text Colors
  static const Color textPrimary = Color(
    0xFF070707,
  ); // Using design system black
  static const Color textSecondary = Color(
    0xFF4F4F4F,
  ); // Using design system gray
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border Colors
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color borderLightGrey = Color(0xFFEEEEEE);

  // Icon Colors
  static const Color iconPrimary = Color(
    0xFF070707,
  ); // Using design system black
  static const Color iconSecondary = Color(
    0xFF4F4F4F,
  ); // Using design system gray
  static const Color iconWhite = Color(0xFFFFFFFF);

  // Button Colors
  static const Color buttonPrimary = Color(
    0xFF7464E4,
  ); // Using design system primary
  static const Color buttonSecondary = Color(0xFFEEEEEE);
  static const Color buttonDisabled = Color(0xFFE0E0E0);

  // Status Colors
  static const Color success = Color(0xFF3CBD53); // Using design system green
  static const Color error = Color(0xFFFF5C5C); // Using design system red
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1A00D2); // Using design system secondary

  // Chip Colors
  static const Color chipActiveBg = Color(
    0xFF7464E4,
  ); // Using design system primary
  static const Color chipActiveText = Color(0xFFFFFFFF);
  static const Color chipInactiveBg = Color(0xFFEEEEEE);
  static const Color chipInactiveText = Color(
    0xFF4F4F4F,
  ); // Using design system gray

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A000000); // 10% black

  // Overlay Colors
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x33000000); // 20% black

  // Primary Color Tints (gradient from dark to light)
  // These represent the 10 circular swatches shown in the design
  static const List<Color> primaryTints = [
    Color(0xFF5A4BC4), // Darkest
    Color(0xFF6252CC),
    Color(0xFF6A5AD4),
    Color(0xFF7262DC),
    Color(0xFF7464E4), // Base primary
    Color(0xFF7C6CEC),
    Color(0xFF8474F4),
    Color(0xFF8C7CFC),
    Color(0xFF9484FF),
    Color(0xFF9C94FF), // Lightest
  ];

  // Secondary Color Tints (gradient from dark to light)
  // These represent the 10 circular swatches shown in the design
  static const List<Color> secondaryTints = [
    Color(0xFF0A00A2), // Darkest
    Color(0xFF0D00B2),
    Color(0xFF1000C2),
    Color(0xFF1300D2),
    Color(0xFF1A00D2), // Base secondary
    Color(0xFF1D00E2),
    Color(0xFF2000F2),
    Color(0xFF2300FF),
    Color(0xFF2600FF),
    Color(0xFF2900FF), // Lightest
  ];
}
