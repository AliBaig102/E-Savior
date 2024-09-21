import 'package:flutter/material.dart';

class MyColors {
  // Light Theme Colors
  static const Color _lightTextColor = Color(0xFF040316);
  static const Color _lightBgPrimaryColor = Color(0xFFFAFAFA);
  static const Color _lightBgSecondaryColor = Color(0x337E8EF1);
  static const Color _lightPrimaryColor = Color(0xFF625ffc);
  static const Color _lightSecondaryColor = Color(0xFF7E8EF1);
  static const Color _lightAccentColor = Color(0xFF10439F);

  // Dark Theme Colors
  static const Color _darkTextColor = Color(0xFFeae9fc);
  static const Color _darkBgPrimaryColor = Color(0xFF0c0c0c);
  static const Color _darkBgSecondaryColor = Colors.black12;
  static const Color _darkPrimaryColor = Color(0xFF625ffc);
  static const Color _darkSecondaryColor = Color(0xFF7E8EF1);
  static const Color _darkAccentColor = Color(0xFF10439F);

  // Getters for Light Theme Colors
  static Color get lightTextColor => _lightTextColor;
  static Color get lightBgPrimaryColor => _lightBgPrimaryColor;
  static Color get lightBgSecondaryColor => _lightBgSecondaryColor;
  static Color get lightPrimaryColor => _lightPrimaryColor;
  static Color get lightSecondaryColor => _lightSecondaryColor;
  static Color get lightAccentColor => _lightAccentColor;

  // Getters for Dark Theme Colors
  static Color get darkTextColor => _darkTextColor;
  static Color get darkBgPrimaryColor => _darkBgPrimaryColor;
  static Color get darkBgSecondaryColor => _darkBgSecondaryColor;
  static Color get darkPrimaryColor => _darkPrimaryColor;
  static Color get darkSecondaryColor => _darkSecondaryColor;
  static Color get darkAccentColor => _darkAccentColor;

  // Methods to get colors based on the current theme
  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextColor
        : lightTextColor;
  }

  static Color bgPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgPrimaryColor
        : lightBgPrimaryColor;
  }

  static Color bgSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgSecondaryColor
        : lightBgSecondaryColor;
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryColor
        : lightPrimaryColor;
  }

  static Color secondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondaryColor
        : lightSecondaryColor;
  }

  static Color accentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkAccentColor
        : lightAccentColor;
  }
}