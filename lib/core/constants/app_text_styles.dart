import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App-wide text styles using Lexend font from design system
/// Lexend font weights: Regular (400), Medium (500), Semi Bold (600)
///
/// All styles use static getters for easy access without requiring BuildContext.
/// The Lexend font is automatically loaded via google_fonts package.
class AppTextStyles {
  // Headings - Using Semi Bold (600) weight
  static TextStyle get heading1 => GoogleFonts.lexend(
    fontSize: 28,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get heading2 => GoogleFonts.lexend(
    fontSize: 24,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get heading3 => GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get heading4 => GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get pricelarge => GoogleFonts.lexend(
    fontSize: 20,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.primaryPurple,
    height: 1.4,
  );

  static TextStyle get purplesmall => GoogleFonts.lexend(
    fontSize: 10,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.primaryPurple,
    height: 1.4,
  );

  // Body Text - Using Regular (400) weight
  static TextStyle get bodyLarge => GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.lexend(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Captions - Using Regular (400) weight
  static TextStyle get caption => GoogleFonts.lexend(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get captionBold => GoogleFonts.lexend(
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Button Text - Using Semi Bold (600) weight
  static TextStyle get buttonLarge => GoogleFonts.lexend(
    fontSize: 16,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textWhite,
    height: 1.2,
  );

  static TextStyle get buttonMedium => GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textWhite,
    height: 1.2,
  );

  static TextStyle get buttonSmall => GoogleFonts.lexend(
    fontSize: 12,
    fontWeight: FontWeight.w600, // Semi Bold
    color: AppColors.textWhite,
    height: 1.2,
  );

  // Links - Using Medium (500) weight
  static TextStyle get link => GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.accentBlue,
    height: 1.5,
  ).copyWith(decoration: TextDecoration.none);

  static TextStyle get linkSmall => GoogleFonts.lexend(
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.accentBlue,
    height: 1.5,
  ).copyWith(decoration: TextDecoration.none);

  // Chip Text - Using Medium (500) weight
  static TextStyle get chipActive => GoogleFonts.lexend(
    fontSize: 13,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.chipActiveText,
    height: 1.2,
  );

  static TextStyle get chipInactive => GoogleFonts.lexend(
    fontSize: 13,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.chipInactiveText,
    height: 1.2,
  );
}
