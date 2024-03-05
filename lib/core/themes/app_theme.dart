import 'package:flutter/material.dart';

class AppTheme {
  static Color lightBackgroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xff90744c);
  static Color lightSecondaryColor = const Color(0xff040415);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticlesColor = const Color(0x44948282);
  static Color lightTextColor = Colors.black12;

  static Color darkBackgroundColor = const Color(0xFF1A2127);
  static Color darkPrimaryColor = const Color(0xff90744c);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkParticlesColor = const Color(0x441C2A3D);
  static Color darkTextColor = Colors.white;
  static Color darkHintColor = Colors.black;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeData().scaffoldBackgroundColor,
      foregroundColor: lightSecondaryColor,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: lightBackgroundColor)),
    colorScheme: ColorScheme.light(secondary: lightSecondaryColor)
        .copyWith(background: lightBackgroundColor),
  );

  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      hintColor: darkHintColor,
      cardColor: darkParticlesColor,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: darkTextColor)),
      colorScheme: ColorScheme.dark(secondary: lightSecondaryColor)
          .copyWith(background: darkBackgroundColor));
}
