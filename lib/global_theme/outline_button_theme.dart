import 'package:echno_attendance/constants/colors.dart';

import 'package:echno_attendance/constants/sizes.dart';
import 'package:flutter/material.dart';

class EchnoOutlinedButtonTheme {
  EchnoOutlinedButtonTheme._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: EchnoColors.dark,
      side: const BorderSide(color: EchnoColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: EchnoColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: EchnoSize.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EchnoSize.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: EchnoColors.light,
      side: const BorderSide(color: EchnoColors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16,
          color: EchnoColors.textWhite,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: EchnoSize.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EchnoSize.buttonRadius)),
    ),
  );
}
