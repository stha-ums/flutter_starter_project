import 'package:flutter/material.dart';
import 'package:starter/config/constants/colors/colors.dart';

class DarkTheme {
  ThemeData call() {
    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.sacaffoldColorDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
    );
  }
}
