import 'package:flutter/material.dart';
import 'package:movie_booking/core/constant/color.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Merriweather',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      primaryColor: Colour.kLightPrimaryColor,
      scaffoldBackgroundColor: Colour.kLightPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colour.kAppBarTransparent,
        foregroundColor: Colour.kLightAppBarForegroud,
      ));
  static final darkTheme = ThemeData();
}
