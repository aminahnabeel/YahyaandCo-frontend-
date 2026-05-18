import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color navyBlue = Color(0xFF102A56);
  static const Color darkBlue = Color(0xFF0B1F4B);
  static const Color blue = Color(0xFF1E4ED8);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const double buttonRadius = 14;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    colorScheme: const ColorScheme.light(
      primary: navyBlue,
      secondary: navyBlue,
      surface: white,
      onPrimary: white,
      onSecondary: white,
      onSurface: Color(0xFF101828),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navyBlue,
      foregroundColor: white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: navyBlue,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: black,
    colorScheme: const ColorScheme.dark(
      primary: blue,
      secondary: blue,
      surface: black,
      onPrimary: white,
      onSecondary: white,
      onSurface: white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBlue,
      foregroundColor: white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
      ),
    ),
  );
}