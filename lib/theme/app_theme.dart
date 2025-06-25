import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // GMGN.AI 品牌色彩
  static const Color primaryGreen = Color(0xFF00D4AA);
  static const Color primaryDark = Color(0xFF0A0A0A);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color borderDark = Color(0xFF2A2A2A);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textTertiary = Color(0xFF5A5A5A);
  static const Color successGreen = Color(0xFF34C759);
  static const Color errorRed = Color(0xFFFF3B30);
  static const Color warningOrange = Color(0xFFFF9500);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryGreen,
      textTheme: GoogleFonts.interTextTheme(),
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: primaryGreen,
        surface: Colors.white,
        background: Colors.white,
        error: errorRed,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: backgroundDark,
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge:
              TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          displayMedium:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          displaySmall:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
          headlineLarge:
              TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          headlineMedium:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          headlineSmall:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
          titleLarge:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          titleMedium:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
          titleSmall:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: textPrimary),
          bodyMedium: TextStyle(color: textSecondary),
          bodySmall: TextStyle(color: textTertiary),
          labelLarge:
              TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(color: textSecondary),
          labelSmall: TextStyle(color: textTertiary),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        secondary: primaryGreen,
        surface: cardDark,
        background: backgroundDark,
        error: errorRed,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: Colors.white,
      ),
      cardTheme: CardTheme(
        color: cardDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderDark, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: borderDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        hintStyle: const TextStyle(color: textTertiary),
        labelStyle: const TextStyle(color: textSecondary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardDark,
        selectedItemColor: primaryGreen,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDark,
        foregroundColor: textPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
