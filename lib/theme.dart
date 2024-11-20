import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = const Color.fromRGBO(28, 28, 30, 1);
  static Color primaryColor = const Color.fromRGBO(76, 137, 227, 1);
  static Color accentColor = const Color.fromRGBO(255, 215, 0, 1);
  static Color secondaryBackground = const Color.fromRGBO(44, 44, 46, 1);
  static Color primaryTextColor = const Color.fromRGBO(228, 228, 230, 1);
  static Color secondaryTextColor = const Color.fromRGBO(142, 142, 147, 1);
  static Color successColor = const Color.fromRGBO(52, 211, 53, 1);
  static Color errorColor = const Color.fromRGBO(255, 90, 95, 1);
}

ThemeData primaryTheme = ThemeData(

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor
  ),

  scaffoldBackgroundColor: AppColors.backgroundColor,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    foregroundColor: AppColors.primaryTextColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true
  ),

  textTheme: const TextTheme().copyWith(
    bodySmall: TextStyle(
      color: AppColors.secondaryTextColor,
      fontSize: 16,
      letterSpacing: 1
    ),
    bodyMedium: TextStyle(
      color: AppColors.secondaryTextColor,
      fontSize: 16,
      letterSpacing: 1,
      fontWeight: FontWeight.w600
    ),
    bodyLarge: TextStyle(
      color: AppColors.secondaryTextColor,
      fontSize: 16,
      letterSpacing: 1,
      fontWeight: FontWeight.w600
    ),
    headlineSmall: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 20,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 24,
      letterSpacing: 1,
      fontWeight: FontWeight.w600
    ),
    headlineLarge: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 28,
      letterSpacing: 1,
      fontWeight: FontWeight.w800
    ),
    titleSmall: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 32,
      letterSpacing: 2
    ),
    titleMedium: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 36,
      letterSpacing: 2,
      fontWeight: FontWeight.w600
    ),
    titleLarge: TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: 40,
      letterSpacing: 2,
      fontWeight: FontWeight.w800
    ),
  )
);