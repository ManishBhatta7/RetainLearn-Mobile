import 'package:flutter/material.dart';

/// Application color palette - Teal Theme
/// 
/// Matches the web RetainLearn design with NotebookLM aesthetic
class AppColors {
  AppColors._();

  // Primary Colors (Teal theme - matching web)
  static const Color primary = Color(0xFF0D9488);     // Teal-600
  static const Color primaryLight = Color(0xFF14B8A6); // Teal-500
  static const Color primaryDark = Color(0xFF0F766E);  // Teal-700
  static const Color primarySurface = Color(0xFFF0FDFA); // Teal-50

  // Secondary Colors (Dark teal for accents)
  static const Color secondary = Color(0xFF115E59);   // Teal-800
  static const Color secondaryLight = Color(0xFF0D9488);
  static const Color secondaryDark = Color(0xFF134E4A); // Teal-900

  // Accent Colors
  static const Color accent = Color(0xFF06B6D4);      // Cyan-500
  static const Color accentLight = Color(0xFF22D3EE); // Cyan-400

  // Semantic Colors
  static const Color success = Color(0xFF10B981);     // Emerald-500
  static const Color successLight = Color(0xFFD1FAE5); // Emerald-100
  static const Color warning = Color(0xFFF59E0B);     // Amber-500
  static const Color warningLight = Color(0xFFFEF3C7); // Amber-100
  static const Color error = Color(0xFFEF4444);       // Red-500
  static const Color errorLight = Color(0xFFFEE2E2); // Red-100
  static const Color info = Color(0xFF3B82F6);        // Blue-500
  static const Color infoLight = Color(0xFFDBEAFE);  // Blue-100

  // Background Colors (Paper aesthetic)
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate-50
  static const Color backgroundDark = Color(0xFF0F172A);  // Slate-900

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);     // Slate-800

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0F172A);  // Slate-900
  static const Color textSecondaryLight = Color(0xFF64748B); // Slate-500
  static const Color textTertiaryLight = Color(0xFF94A3B8); // Slate-400
  static const Color textPrimaryDark = Color(0xFFF1F5F9);   // Slate-100
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Slate-400

  // Border Colors
  static const Color borderLight = Color(0xFFE2E8F0);  // Slate-200
  static const Color borderDark = Color(0xFF475569);   // Slate-600

  // Source Type Colors (matching web nb.* palette)
  static const Color sourceAssignment = Color(0xFF3B82F6); // Blue
  static const Color sourceReport = Color(0xFF10B981);     // Emerald
  static const Color sourceQuiz = Color(0xFF8B5CF6);       // Violet
  static const Color sourceReading = Color(0xFFF59E0B);    // Amber
  static const Color sourceEssay = Color(0xFFEC4899);      // Pink
  static const Color sourceDoubt = Color(0xFF06B6D4);      // Cyan

  // Gradient Definitions (Teal-based)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF0891B2)], // Teal to Cyan-600
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFF0FDFA), Color(0xFFECFEFF)], // Teal-50 to Cyan-50
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient subtleGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFF0FDFA)], // Slate-50 to Teal-50
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
