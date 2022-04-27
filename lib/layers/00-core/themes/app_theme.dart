import 'package:flutter/material.dart';

ThemeData get themeDataLight {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.blue,
    ),
    splashColor: Colors.transparent,
    fontFamily: 'IBM',
  );
}
