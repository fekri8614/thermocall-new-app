import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();
  factory AppTheme() => _instance;

  ThemeData darkTheme() => ThemeData.dark(useMaterial3: true);
  ThemeData lightTheme() => ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.accentColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor.withAlpha(20),
          elevation: 0,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: AppColors.primaryColor.withAlpha(20),
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );
}
