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

class EchnoElevatedButtonTheme {
  EchnoElevatedButtonTheme._();

/* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: EchnoColors.light,
      backgroundColor: EchnoColors.primary,
      disabledForegroundColor: EchnoColors.darkGrey,
      disabledBackgroundColor: EchnoColors.buttonDisabled,
      side: const BorderSide(color: EchnoColors.primary),
      padding: const EdgeInsets.symmetric(vertical: EchnoSize.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16,
          color: EchnoColors.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EchnoSize.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: EchnoColors.dark,
      backgroundColor: EchnoColors.secondary,
      disabledForegroundColor: EchnoColors.darkGrey,
      disabledBackgroundColor: EchnoColors.darkerGrey,
      side: const BorderSide(color: EchnoColors.secondary),
      padding: const EdgeInsets.symmetric(vertical: EchnoSize.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16,
          color: EchnoColors.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EchnoSize.buttonRadius)),
    ),
  );
}
