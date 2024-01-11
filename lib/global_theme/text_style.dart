import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class EchnoTextTheme {
  EchnoTextTheme._(); // Private constructor

/*-- Light Theme Text Style --*/
  static TextTheme lightTextTheme = const TextTheme(
    displayMedium: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: echnoLightColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: echnoLightColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: echnoLightColor,
    ),
    titleMedium: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 17,
      color: echnoLightColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: echnoLightColor,
    ),
  );

/*-- Dark Theme Text Style --*/

  static TextTheme darkTextTheme = const TextTheme(
    displayMedium: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 38,
      fontWeight: FontWeight.w600,
      color: whiteColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 34,
      fontWeight: FontWeight.w500,
      color: whiteColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: whiteColor,
    ),
    titleMedium: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 17,
      color: whiteColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'TT Chocolates',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: whiteColor,
    ),
  );
}
