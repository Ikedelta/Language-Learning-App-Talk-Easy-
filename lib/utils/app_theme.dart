import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);

  // Text Colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;
  static const Color onError = Colors.white;

  // Achievement Colors
  static const Color gold = Color(0xFFFFD700);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);

  // Level Colors
  static const Color beginner = Color(0xFF4CAF50);
  static const Color intermediate = Color(0xFFFFC107);
  static const Color advanced = Color(0xFFF44336);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        primary: primaryColor,
        primaryContainer: primaryVariant,
        secondary: secondaryColor,
        secondaryContainer: secondaryVariant,
        surface: surface,
        background: background,
        error: error,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface,
        onBackground: onBackground,
        onError: onError,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: surface,
        foregroundColor: onSurface,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: primaryColor,
        primaryContainer: primaryVariant,
        secondary: secondaryColor,
        secondaryContainer: secondaryVariant,
        surface: const Color(0xFF121212),
        background: const Color(0xFF000000),
        error: error,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: onError,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF121212),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 8,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
