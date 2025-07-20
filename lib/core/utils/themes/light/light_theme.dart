import 'package:flutter/material.dart';
import '../../colors/colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightappbackground,
  primaryColor: AppColors.blue,
  colorScheme: ColorScheme.light(
    primary: AppColors.blue,
    secondary: AppColors.orange,
    error: AppColors.red,
    background: AppColors.lightappbackground,
    onPrimary: AppColors.white,
    onSecondary: AppColors.black,
  ),
  iconTheme: const IconThemeData(color: AppColors.darkicon),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightappbackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.darkicon),
    titleTextStyle: TextStyle(
      color: AppColors.red,
      fontSize: 18,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontFamily: 'Inter',
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkappbackground,
  primaryColor: AppColors.blue,
  colorScheme: ColorScheme.dark(
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
);

extension ThemeColors on BuildContext {
  Color get appbackground =>
      Theme.of(this).brightness == Brightness.dark
          ? AppColors.darkappbackground
          : AppColors.lightappbackground;

  Color get icon =>
      Theme.of(this).brightness == Brightness.dark
          ? AppColors.darkicon
          : AppColors.lighticon;

  Color get nonselecedtext =>
      Theme.of(this).brightness == Brightness.dark
          ? AppColors.darknonselecedtext
          : AppColors.lightnonselecedtext;

  Color get textt =>
      Theme.of(this).brightness == Brightness.dark
          ? AppColors.darktext
          : AppColors.lighttext;
}
