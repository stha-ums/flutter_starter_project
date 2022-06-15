import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter_proj/config/constants/colors/colors.dart';

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

  // return cupertino dark theme data
  CupertinoThemeData cupertino() {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      primaryContrastingColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.sacaffoldColorDark,
      barBackgroundColor: AppColors.primaryColor,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
