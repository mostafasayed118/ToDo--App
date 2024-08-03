import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData(
    //brightness
    brightness: Brightness.dark,
    //primary color
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.background,
    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.white,
        fontSize: 16,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.white.withOpacity(0.44),
        fontSize: 16,
      ),
    ),
    //button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        //enabled border
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //focused border
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

        //hint
        hintStyle: GoogleFonts.lato(
          color: AppColors.white,
          fontSize: 16,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        //fill color
        fillColor: AppColors.deepGrey,
        filled: true),
  );
}

ThemeData getAppLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.white,
    //appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        color: AppColors.background,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      displayMedium: GoogleFonts.lato(
        color: AppColors.background,
        fontSize: 16,
      ),
      displaySmall: GoogleFonts.lato(
        color: AppColors.background.withOpacity(0.44),
        fontSize: 16,
      ),
    ),
    //button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        //enabled border
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //focused border
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        //hint
        hintStyle: GoogleFonts.lato(
          color: AppColors.background,
          fontSize: 16,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        //fill color
        fillColor: AppColors.white,
        filled: true),
  );
}
