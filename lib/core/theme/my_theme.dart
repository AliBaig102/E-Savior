import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../my_colors.dart';

class MyTheme {
  // Light Theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.lightBgPrimaryColor,
      colorScheme: ColorScheme.light(
        primary: MyColors.lightBgPrimaryColor,
        secondary: MyColors.lightBgSecondaryColor,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 14,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.lightTextColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.lightBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: MyColors.lightTextColor,
          backgroundColor: MyColors.lightPrimaryColor, // Button text color
        ),
      ),
      // Add other button themes if needed
    );
  }

  // Dark Theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: MyColors.darkBgPrimaryColor,
      colorScheme: ColorScheme.dark(
        primary: MyColors.darkBgPrimaryColor,
        secondary: MyColors.darkBgSecondaryColor,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 14,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.darkTextColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.darkBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      scaffoldBackgroundColor: MyColors.darkBgPrimaryColor,
      dialogBackgroundColor: MyColors.darkBgPrimaryColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: MyColors.darkBgPrimaryColor,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: MyColors.darkBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: MyColors.darkBgPrimaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: MyColors.darkTextColor,
          backgroundColor: MyColors.darkPrimaryColor, // Button text color
        ),
      ),
      // Add other button themes if needed
    );
  }
}
