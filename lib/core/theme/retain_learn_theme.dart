import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// RetainLearn Design System
///
/// Mirrors the Web "NotebookLM" aesthetic:
/// - Teal Primary (#0D9488)
/// - Paper White Surface (#FFFFFF) with subtle borders
/// - Serif Headings (Merriweather) + Sans Body (Inter)
/// - Glassmorphism for overlays and chips
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
  static const Color paperOffWhite = Color(0xFFF8FAFC); // Slate-50 (Web: #F8F9FA)
  static const Color grayBorder = Color(0xFFE2E8F0);    // Slate-200
  static const Color textDark = Color(0xFF0F172A);      // Slate-900
  static const Color textMedium = Color(0xFF64748B);    // Slate-500
  static const Color textLight = Color(0xFF94A3B8);     // Slate-400

  // Source Type Colors (Matches Web nb.* colors)
  static const Color sourceAssignment = Color(0xFF3B82F6);  // Blue
  static const Color sourceReport = Color(0xFF10B981);      // Emerald
  static const Color sourceQuiz = Color(0xFF8B5CF6);        // Violet
  static const Color sourceReading = Color(0xFFF59E0B);     // Amber
  static const Color sourceEssay = Color(0xFFEC4899);       // Pink
  static const Color sourceDoubt = Color(0xFF06B6D4);       // Cyan

  // ===================================
  // TYPOGRAPHY STYLES
  // ===================================

  /// Card Header Style - Bold, tight letter spacing
  static TextStyle get cardHeaderStyle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
    letterSpacing: -0.5,
  );

  /// AI Streaming Text Style - Readable with generous line height
  static TextStyle get streamingTextStyle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textDark,
    height: 1.6,
  );

  /// Source Chip Label Style
  static TextStyle get chipLabelStyle => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textMedium,
  );

  static TextTheme get _textTheme {
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
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
        letterSpacing: -0.3,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
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
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
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
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMedium,
      ),
      
      // Labels
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMedium,
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
        tertiary: tealLight,
        surface: paperWhite,
        onSurface: textDark,
        surfaceContainerHighest: paperOffWhite,
        outline: grayBorder,
        outlineVariant: grayBorder.withOpacity(0.5),
      ),

      // Background
      scaffoldBackgroundColor: paperOffWhite,

      // Typography
      textTheme: _textTheme,
      
      // App Bar - Glassmorphism style
      appBarTheme: AppBarTheme(
        backgroundColor: paperWhite.withOpacity(0.85),
        foregroundColor: textDark,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        iconTheme: const IconThemeData(color: textMedium),
      ),

      // Card Theme (Paper Style)
      cardTheme: CardTheme(
        color: paperWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: grayBorder),
        ),
        margin: EdgeInsets.zero,
      ),

      // Chip Theme - Glassmorphism Pills
      chipTheme: ChipThemeData(
        backgroundColor: paperWhite.withOpacity(0.8),
        deleteIconColor: textLight,
        disabledColor: paperOffWhite,
        selectedColor: tealSurface,
        secondarySelectedColor: tealLight,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textMedium,
        ),
        secondaryLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: tealDark,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: grayBorder),
        ),
        elevation: 0,
      ),

      // Filled Button - Pill shaped
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: tealPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Elevated Button
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

      // Outlined Button - Pill shaped
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tealPrimary,
          side: const BorderSide(color: grayBorder),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: tealPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Icon Button
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: textMedium,
          hoverColor: tealSurface,
        ),
      ),

      // Inputs - Rounded, filled
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: paperWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: grayBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: grayBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: tealPrimary, width: 2),
        ),
        hintStyle: TextStyle(color: textLight),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: paperWhite,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titleTextStyle: GoogleFonts.merriweather(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: textMedium,
          height: 1.5,
        ),
      ),

      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: paperWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        elevation: 8,
      ),

      // Floating Action Button - Pill style
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: tealPrimary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Navigation Bar (Mobile) - Floating style
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paperWhite,
        indicatorColor: tealSurface,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tealPrimary,
            );
          }
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textLight,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: tealPrimary);
          }
          return const IconThemeData(color: textLight);
        }),
      ),

      // Bottom Navigation Bar (Legacy)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: paperWhite,
        selectedItemColor: tealPrimary,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      
      // Navigation Rail (Desktop)
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: paperWhite,
        selectedIconTheme: const IconThemeData(color: tealPrimary),
        unselectedIconTheme: const IconThemeData(color: textLight),
        indicatorColor: tealSurface,
        useIndicator: true,
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: tealPrimary,
        ),
        unselectedLabelTextStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textLight,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: grayBorder,
        thickness: 1,
        space: 1,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textDark,
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: tealPrimary,
        linearTrackColor: grayBorder,
      ),

      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.transparent,
        selectedTileColor: tealSurface,
      ),
    );
  }
}
