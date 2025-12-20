import 'package:flutter/material.dart';

/// Application color palette
/// 
/// Follows the design system from the web application
class AppColors {
  AppColors._();

  // Primary Colors (Purple/Pink gradient theme)
  static const Color primary = Color(0xFF9333EA); // Purple-600
  static const Color primaryLight = Color(0xFFA855F7); // Purple-500
  static const Color primaryDark = Color(0xFF7E22CE); // Purple-700

  // Secondary Colors (Pink accent)
  static const Color secondary = Color(0xFFDB2777); // Pink-600
  static const Color secondaryLight = Color(0xFFEC4899); // Pink-500
  static const Color secondaryDark = Color(0xFFBE185D); // Pink-700

  // Accent Colors
  static const Color accent = Color(0xFF06B6D4); // Cyan-500
  static const Color accentLight = Color(0xFF22D3EE); // Cyan-400

  // Semantic Colors
  static const Color success = Color(0xFF22C55E); // Green-500
  static const Color successLight = Color(0xFFDCFCE7); // Green-100
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color warningLight = Color(0xFFFEF3C7); // Amber-100
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color errorLight = Color(0xFFFEE2E2); // Red-100
  static const Color info = Color(0xFF3B82F6); // Blue-500
  static const Color infoLight = Color(0xFFDBEAFE); // Blue-100

  // Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB); // Gray-50
  static const Color backgroundDark = Color(0xFF111827); // Gray-900

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937); // Gray-800

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF111827); // Gray-900
  static const Color textSecondaryLight = Color(0xFF6B7280); // Gray-500
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Gray-50
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // Gray-400

  // Border Colors
  static Color borderLight = Colors.grey.shade200;
  static Color borderDark = Colors.grey.shade700;

  // Subject-specific Colors (matching web app)
  static const Color subjectMath = Color(0xFF3B82F6); // Blue
  static const Color subjectScience = Color(0xFF22C55E); // Green
  static const Color subjectLiterature = Color(0xFFA855F7); // Purple
  static const Color subjectHistory = Color(0xFFF59E0B); // Amber
  static const Color subjectLanguage = Color(0xFFEC4899); // Pink
  static const Color subjectArt = Color(0xFF6366F1); // Indigo
  static const Color subjectMusic = Color(0xFFF43F5E); // Rose
  static const Color subjectCS = Color(0xFF06B6D4); // Cyan
  static const Color subjectPE = Color(0xFF84CC16); // Lime

  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)], // Purple-50 to Pink-50
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF2E1065), Color(0xFF500724)], // Purple-950 to Pink-950
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
