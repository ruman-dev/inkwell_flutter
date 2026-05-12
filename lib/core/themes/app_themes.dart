import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D0D0F),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        onPrimary: Colors.black,
        surface: Color(0xFF1D1E22),
        secondary: Colors.grey,
        error: Colors.redAccent,
      ),

      /// Typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          letterSpacing: -.5,
        ),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
        bodyMedium: TextStyle(color: Color(0xFF9E9E9E), fontSize: 15),
      ),

      /// Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1D1E22),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 18,
        ),
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIconColor: Colors.grey.shade500,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: .04)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: .12)),
        ),
      ),

      /// Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          disabledBackgroundColor: Colors.grey.withValues(alpha: .5),
          disabledForegroundColor: Colors.white.withValues(alpha: .5),
        ),
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.dark,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withValues(alpha: .08)),
          backgroundColor: const Color(0xFF1D1E22),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),

      /// Divider Theme
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: .08),
        thickness: 1,
      ),
    );
  }
}
