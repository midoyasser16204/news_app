import 'package:flutter/material.dart';
import '../../colors/colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkappbackground,
  primaryColor: AppColors.blue,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.blue,
    secondary: AppColors.orange,
    error: AppColors.red,
    background: AppColors.darkappbackground,
    onPrimary: AppColors.black,
    onSecondary: AppColors.white,
  ),
  iconTheme: const IconThemeData(color: AppColors.lighticon),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkappbackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.lighticon),
    titleTextStyle: TextStyle(
      color: AppColors.red,
      fontSize: 18,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontFamily: 'Inter',
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.white),
    bodyMedium: TextStyle(color: AppColors.lightGrey),
    titleLarge: TextStyle(color: AppColors.white),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2C2C2C),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: AppColors.grey),
  ),
  cardColor: const Color(0xFF1E1E1E),
  dividerColor: AppColors.grey,
);
