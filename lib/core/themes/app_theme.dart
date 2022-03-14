import 'package:flutter/material.dart';

ThemeData get themeDataLight {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.black,
      secondary: Colors.black,
    ),
    splashColor: Colors.transparent,
    fontFamily: 'IBM',
  );
}
