import 'package:flutter/material.dart';
import 'package:starter/config/constants/colors/colors.dart';

class LightTheme {
  ThemeData call() {
    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.scaffoldColorLight,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
    );
  }
}
