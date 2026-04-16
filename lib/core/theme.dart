import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF1CB0F6); // Duolingo blue
  static const Color secondary = Color(0xFF78C800); // Duolingo green
  static const Color accent = Color(0xFFFF4B4B); // Duolingo red
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF7F7F7);
  static const Color textBody = Color(0xFF4B4B4B);
  static const Color textTitle = Color(0xFF3C3C3C);
  static const Color border = Color(0xFFE5E5E5);
  
  // Progress colors
  static const Color progressBackground = Color(0xFFE5E5E5);
  static const Color xpColor = Color(0xFFFFC800);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: AppColors.textTitle,
        ),
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: AppColors.textTitle,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
