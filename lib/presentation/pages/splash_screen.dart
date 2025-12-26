import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/retain_learn_theme.dart';

/// Splash Screen - Shown while checking auth state
///
/// Displays a loading spinner with branding while the app
/// determines if the user is logged in.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: RetainLearnTheme.tealPrimary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: RetainLearnTheme.tealPrimary.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_stories,
                color: Colors.white,
                size: 48,
              ),
            ),
            const SizedBox(height: 32),
            
            // App Name
            Text(
              'RetainLearn',
              style: GoogleFonts.merriweather(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: RetainLearnTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Intelligent Notebook',
              style: TextStyle(
                fontSize: 14,
                color: RetainLearnTheme.textMedium,
              ),
            ),
            const SizedBox(height: 48),
            
            // Loading Indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: RetainLearnTheme.tealPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 13,
                color: RetainLearnTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
