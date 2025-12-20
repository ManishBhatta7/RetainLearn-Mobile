import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// RetainLearn Design System
///
/// Mirrors the Web "NotebookLM" aesthetic:
/// - Teal Primary (#0F766E)
/// - Paper White Surface (#FFFFFF) with subtle borders
/// - Serif Headings (Merriweather/Playfair) + Sans Body (Inter)
class RetainLearnTheme {
  RetainLearnTheme._();

  // ===================================
  // COLORS
  // ===================================

  // Primary Teal (Web: hsl(174 84% 40%))
  static const Color tealPrimary = Color(0xFF0D9488); // Teal-600
  static const Color tealLight = Color(0xFF99F6E4);   // Teal-200
  static const Color tealDark = Color(0xFF0F766E);    // Teal-700
  static const Color tealSurface = Color(0xFFF0FDFA); // Teal-50

  // Neutrals (Paper Aesthetic)
  static const Color paperWhite = Color(0xFFFFFFFF);
  static const Color paperOffWhite = Color(0xFFFAFAFA); // Slate-50
  static const Color grayBorder = Color(0xFFE2E8F0);    // Slate-200
  static const Color textDark = Color(0xFF0F172A);      // Slate-900
  static const Color textMedium = Color(0xFF64748B);    // Slate-500
  static const Color textLight = Color(0xFF94A3B8);     // Slate-400

  // ===================================
  // TYPOGRAPHY
  // ===================================

  static TextTheme get _textTheme {
    // We use GoogleFonts.inter for body and Playfair/Merriweather for headers
    // But since internet might be flaky, we can fall back to standard fonts
    return TextTheme(
      // Headlines - Serif, Intellectual
      displayLarge: GoogleFonts.merriweather(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textDark,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textDark,
        letterSpacing: -0.5,
      ),
      
      // Titles - Sans, Clean
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),

      // Body - Sans, Readable
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textDark,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textMedium,
        height: 1.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textLight,
        letterSpacing: 0.5,
      ),
    );
  }

  // ===================================
  // THEME DATA
  // ===================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Colors
      colorScheme: ColorScheme.light(
        primary: tealPrimary,
        onPrimary: Colors.white,
        secondary: tealDark,
        onSecondary: Colors.white,
        surface: paperWhite,
        onSurface: textDark,
        surfaceContainerHighest: paperOffWhite,
        outline: grayBorder,
      ),

      // Background
      scaffoldBackgroundColor: paperOffWhite,

      // Typography
      textTheme: _textTheme,
      
      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: paperWhite.withOpacity(0.8),
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        iconTheme: const IconThemeData(color: textMedium),
      ),

      // Card Theme (Glass/Paper Style)
      cardTheme: CardTheme(
        color: paperWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: grayBorder),
        ),
        margin: EdgeInsets.zero,
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: paperWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grayBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grayBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: tealPrimary, width: 2),
        ),
        hintStyle: TextStyle(color: textLight),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tealPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Navigation Bar (Mobile)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: paperWhite,
        selectedItemColor: tealPrimary,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      
      // Navigation Rail (Desktop)
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: paperOffWhite,
        selectedIconTheme: IconThemeData(color: tealPrimary),
        unselectedIconTheme: IconThemeData(color: textLight),
        indicatorColor: tealSurface,
        useIndicator: true,
        labelType: NavigationRailLabelType.all,
      ),
    );
  }
}
