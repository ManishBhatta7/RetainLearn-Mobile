import 'package:flutter/material.dart';

/// NotebookLM-Inspired Design System for Flutter
/// 
/// Clean, minimalist, content-focused design language with:
/// - Neutral color palette with source-type accents
/// - Generous whitespace and rounded corners
/// - Subtle shadows and borders
/// - Scale-based typography hierarchy
class NotebookTheme {
  NotebookTheme._();

  // ============================================================================
  // COLOR PALETTE - Neutral, High-Contrast with Source-Type Accents
  // ============================================================================
  
  // Base Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF8FAFC);
  static const Color gray100 = Color(0xFFF1F5F9);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E1);
  static const Color gray400 = Color(0xFF94A3B8);
  static const Color gray500 = Color(0xFF64748B);
  static const Color gray600 = Color(0xFF475569);
  static const Color gray700 = Color(0xFF334155);
  static const Color gray800 = Color(0xFF1E293B);
  static const Color gray900 = Color(0xFF0F172A);
  
  // Source Type Accent Colors
  static const Color sourceAssignment = Color(0xFF3B82F6);  // Blue
  static const Color sourceReport = Color(0xFF10B981);      // Emerald
  static const Color sourceQuiz = Color(0xFF8B5CF6);        // Violet
  static const Color sourceReading = Color(0xFFF59E0B);     // Amber
  static const Color sourceEssay = Color(0xFFEC4899);       // Pink
  static const Color sourceDoubt = Color(0xFF06B6D4);       // Cyan
  static const Color sourceClassroom = Color(0xFF14B8A6);   // Teal
  
  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Primary (Subtle, content-focused)
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryLight = Color(0xFFDBEAFE);
  static const Color primaryDark = Color(0xFF1D4ED8);
  
  // Background Colors
  static const Color background = gray50;
  static const Color surface = white;
  static const Color surfaceElevated = white;
  
  // ============================================================================
  // SOURCE TYPE COLOR CONFIGURATIONS
  // ============================================================================
  
  static Map<String, SourceTypeColors> sourceTypeColors = {
    'assignment': SourceTypeColors(
      primary: sourceAssignment,
      background: const Color(0xFFDBEAFE),
      border: sourceAssignment,
    ),
    'report': SourceTypeColors(
      primary: sourceReport,
      background: const Color(0xFFD1FAE5),
      border: sourceReport,
    ),
    'quiz': SourceTypeColors(
      primary: sourceQuiz,
      background: const Color(0xFFEDE9FE),
      border: sourceQuiz,
    ),
    'reading': SourceTypeColors(
      primary: sourceReading,
      background: const Color(0xFFFEF3C7),
      border: sourceReading,
    ),
    'essay': SourceTypeColors(
      primary: sourceEssay,
      background: const Color(0xFFFCE7F3),
      border: sourceEssay,
    ),
    'doubt': SourceTypeColors(
      primary: sourceDoubt,
      background: const Color(0xFFCFFAFE),
      border: sourceDoubt,
    ),
    'classroom': SourceTypeColors(
      primary: sourceClassroom,
      background: const Color(0xFFCCFBF1),
      border: sourceClassroom,
    ),
  };
  
  // ============================================================================
  // SPACING
  // ============================================================================
  
  static const double space0 = 0;
  static const double space1 = 4;
  static const double space2 = 8;
  static const double space3 = 12;
  static const double space4 = 16;
  static const double space5 = 20;
  static const double space6 = 24;
  static const double space8 = 32;
  static const double space10 = 40;
  static const double space12 = 48;
  static const double space16 = 64;
  
  // ============================================================================
  // BORDER RADIUS
  // ============================================================================
  
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radius2xl = 24;
  
  static BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static BorderRadius borderRadius2xl = BorderRadius.circular(radius2xl);
  
  // ============================================================================
  // SHADOWS - Subtle, Clean
  // ============================================================================
  
  static List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Colors.black.withOpacity(0.03),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
  
  static List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 15,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 6,
      offset: const Offset(0, 4),
    ),
  ];
  
  // ============================================================================
  // THEME DATA
  // ============================================================================
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: white,
        primaryContainer: primaryLight,
        secondary: gray600,
        onSecondary: white,
        surface: surface,
        onSurface: gray900,
        background: background,
        onBackground: gray900,
        error: error,
        onError: white,
        outline: gray200,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: background,
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: gray900,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: gray900,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      
      // Card
      cardTheme: CardTheme(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusXl,
          side: const BorderSide(color: gray100, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusLg,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: gray700,
          side: const BorderSide(color: gray200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusLg,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
      
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadiusMd,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: borderRadiusLg,
          borderSide: const BorderSide(color: gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadiusLg,
          borderSide: const BorderSide(color: gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadiusLg,
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadiusLg,
          borderSide: const BorderSide(color: error),
        ),
        hintStyle: const TextStyle(color: gray400, fontSize: 14),
        labelStyle: const TextStyle(color: gray500, fontSize: 14),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primary,
        unselectedItemColor: gray400,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusLg,
        ),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: gray100,
        labelStyle: const TextStyle(color: gray700, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusSm,
        ),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: gray100,
        thickness: 1,
        space: 1,
      ),
      
      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMd,
        ),
        titleTextStyle: const TextStyle(
          color: gray900,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
        subtitleTextStyle: const TextStyle(
          color: gray500,
          fontSize: 13,
          fontFamily: 'Inter',
        ),
      ),
      
      // Bottom Sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      
      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius2xl,
        ),
        titleTextStyle: const TextStyle(
          color: gray900,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: gray800,
        contentTextStyle: const TextStyle(color: white, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusMd,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: gray900),
        displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: gray900),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: gray900),
        headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: gray900),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: gray900),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: gray900),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: gray900),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: gray900),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: gray900),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: gray700),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: gray700),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: gray500),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: gray900),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gray600),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: gray500),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: gray900,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        onPrimary: white,
        primaryContainer: Color(0xFF1E3A5F),
        secondary: gray400,
        onSecondary: gray900,
        surface: gray800,
        onSurface: gray100,
        background: gray900,
        onBackground: gray100,
        error: error,
        onError: white,
        outline: gray700,
      ),
    );
  }
}

/// Helper class for source type color configuration
class SourceTypeColors {
  final Color primary;
  final Color background;
  final Color border;
  
  const SourceTypeColors({
    required this.primary,
    required this.background,
    required this.border,
  });
}
