import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_color_constants.dart';

class LightTheme {
  final _switchTheme = SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith((states) => kPrimaryLightColor),
    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.black),
    trackColor: MaterialStateProperty.resolveWith((states) => Colors.green),
  );

  final _appBarTheme = AppBarTheme(brightness: Brightness.dark, elevation: 0);

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
    subtitle2: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
    caption: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.black),
    overline: TextStyle(color: Colors.black),
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
    return ThemeData.light().copyWith(
      primaryColor: kPrimaryLightColor,
      switchTheme: _switchTheme,
      appBarTheme: _appBarTheme,
      textButtonTheme: _textButtonTheme,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }
}
