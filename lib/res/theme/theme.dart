import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.accentColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor.withAlpha(20),
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.primaryColor.withAlpha(20),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColor),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
      ),
    ),
  );
}
