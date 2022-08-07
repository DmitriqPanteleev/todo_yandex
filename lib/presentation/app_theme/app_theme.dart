import 'package:flutter/material.dart';
import 'package:todo_list/presentation/app_theme/color_pallete.dart';

abstract class AppTheme {
  static const _defaultFontFamily = 'Roboto';

  static ThemeData lightTheme() {
    final theme = ThemeData(
      textTheme: const TextTheme(
        // Large Title - 32/38
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
          height: 38 / 32,
        ),
        // Title 30/32
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          height: 32 / 20,
        ),
        // Button - 14/24
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          height: 24.0 / 14.0,
        ),
        // Body - 16/20
        headline4: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          height: 20.0 / 16.0,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          height: 20.0 / 14.0,
        ),
      ),
      colorScheme: const ColorScheme(
        background: C.backPrimaryLight,
        onBackground: C.labelPrimaryLight,
        primary: C.blueLight,
        onPrimary: C.labelPrimaryLight,
        secondary: C.blueLight,
        onSecondary: C.whiteLight,
        error: C.redLight,
        onError: C.redLight,
        surface: C.overlayLight,
        onSurface: C.overlayLight,
        brightness: Brightness.light,
      ),
      fontFamily: _defaultFontFamily,
    );
    return theme;
  }
}
