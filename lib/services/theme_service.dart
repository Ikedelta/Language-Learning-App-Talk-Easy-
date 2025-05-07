import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const double defaultPadding = 16.0;

  final SharedPreferences _prefs;
  ThemeMode _themeMode;

  // Colors
  final Color primaryColor = const Color(0xFF2196F3);
  final Color secondaryColor = const Color(0xFF03A9F4);
  final Color accentColor = const Color(0xFF00BCD4);
  final Color errorColor = const Color(0xFFE53935);
  final Color successColor = const Color(0xFF43A047);
  final Color warningColor = const Color(0xFFFFA000);
  final Color backgroundColor = const Color(0xFFF5F5F5);
  final Color surfaceColor = Colors.white;
  final Color textColor = const Color(0xFF212121);
  final Color subtitleColor = const Color(0xFF757575);

  ThemeService(this._prefs)
      : _themeMode = ThemeMode.values[_prefs.getInt(_themeKey) ?? 0];

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Text Styles
  TextStyle get headlineStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      );

  TextStyle get titleStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF212121),
      );

  TextStyle get subtitleStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF757575),
      );

  TextStyle get bodyStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF212121),
      );

  TextStyle get captionStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF757575),
      );

  TextStyle get buttonTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  TextStyle get errorTextStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE53935),
      );

  // Theme Data
  ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          error: errorColor,
          background: backgroundColor,
          surface: surfaceColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: titleStyle.copyWith(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: errorColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
          error: errorColor,
          background: const Color(0xFF121212),
          surface: const Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: titleStyle.copyWith(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: const Color(0xFF1E1E1E),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: errorColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      );

  // Common styles
  static const double defaultBorderRadius = 12.0;
  static const double defaultIconSize = 24.0;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Common gradients
  static const List<Color> primaryGradient = [
    Color(0xFF2196F3),
    Color(0xFF1976D2),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF4CAF50),
    Color(0xFF388E3C),
  ];

  static const List<Color> accentGradient = [
    Color(0xFFFFC107),
    Color(0xFFFFA000),
  ];

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _prefs.setInt(_themeKey, _themeMode.index);
    notifyListeners();
  }
}
