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
    ),
  );
}
