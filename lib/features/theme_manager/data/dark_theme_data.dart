import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter/features/theme_manager/data/theme_color_constants.dart';

class DarkTheme {
  final _switchTheme = SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith((states) => kPrimaryLightColor),
    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black),
    trackColor: MaterialStateProperty.resolveWith((states) => Colors.green),
  );

  final _appBarTheme = AppBarTheme(
    elevation: 0,
    brightness: Brightness.dark,
  );

  final _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      enableFeedback: true,
      padding: MaterialStateProperty.resolveWith<EdgeInsets>(
          (states) => EdgeInsets.all(0)),
      foregroundColor:
          MaterialStateProperty.resolveWith<Color>((states) => Colors.white),
    ),
  );

  final _textTheme = GoogleFonts.muktaTextTheme().copyWith(
    subtitle2: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
    headline1: TextStyle(color: Colors.white),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
    subtitle1: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.white),
    caption: TextStyle(color: Colors.white),
    button: TextStyle(color: Colors.white),
    overline: TextStyle(color: Colors.white),
  );

  final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      shape:
          MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => Color(0xfff57a00)),
    ),
  );

  ThemeData call() {
    return ThemeData.dark().copyWith(
      primaryColor: kPrimaryLightColor,
      switchTheme: _switchTheme,
      appBarTheme: _appBarTheme,
      textButtonTheme: _textButtonTheme,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      splashColor: kPrimaryLightColor.withOpacity(.2),
    );
  }
}
