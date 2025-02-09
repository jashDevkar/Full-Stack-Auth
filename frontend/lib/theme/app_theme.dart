import 'package:flutter/material.dart';
import 'package:frontend/theme/pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: color),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: AppBarTheme(color: Pallete.backgroundColor),
    chipTheme: ChipThemeData(
      color: MaterialStatePropertyAll(Pallete.backgroundColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(18.0),
      enabledBorder: _border(Pallete.inputBorder),
      focusedBorder: _border(Pallete.whiteColor),
      errorBorder: _border(Pallete.redColor),
      focusedErrorBorder: _border(Pallete.redColor),
      floatingLabelStyle: TextStyle(color: Pallete.whiteColor),
      errorStyle: TextStyle(color: Colors.red),
    ),
  );
}
