import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static final AppColors _instance = AppColors._();
  factory AppColors() => _instance;

  static const Color primaryColor = Color.fromRGBO(241, 249, 255, 1);
  static Color accentColor = const Color.fromRGBO(4, 96, 217, 1);
  static Color blackBlue = const Color.fromRGBO(0, 49, 109, 1);
  static Color redColor = Colors.red;
}
