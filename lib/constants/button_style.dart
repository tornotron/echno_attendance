import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class EchnoOutlinedButtonTheme {
  EchnoOutlinedButtonTheme._();

//Light
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(300, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: echnoLogoColor,
      side: const BorderSide(color: echnoLogoColor),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      textStyle: const TextStyle(
        fontSize: 17.0,
        fontFamily: 'TT Chocolates',
      ),
    ),
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(300, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: whiteColor,
      side: const BorderSide(color: whiteColor),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      textStyle: const TextStyle(
        fontSize: 17.0,
        fontFamily: 'TT Chocolates',
      ),
    ),
  );
}

class EchnoElevatedButtonTheme {
  EchnoElevatedButtonTheme._();

//Light
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(300, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: whiteColor,
      side: const BorderSide(color: echnoLogoColor),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      textStyle: const TextStyle(
        fontSize: 17.0,
        fontFamily: 'TT Chocolates',
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(300, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: whiteColor,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      textStyle: const TextStyle(
        fontSize: 17.0,
        fontFamily: 'TT Chocolates',
      ),
    ),
  );
}
