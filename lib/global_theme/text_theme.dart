import 'package:echno_attendance/constants/colors.dart';
import 'package:flutter/material.dart';

class EchnoTextTheme {
  EchnoTextTheme._(); // Private constructor

/*-- Light Theme Text Style --*/
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: EchnoColors.dark,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.dark,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.dark,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.dark,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.dark,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: EchnoColors.dark,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.dark,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: EchnoColors.dark,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.dark.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: EchnoColors.dark,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: EchnoColors.dark.withOpacity(0.5),
    ),
  );

  /*-- Dark Theme Text Style --*/
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: EchnoColors.light,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.light,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.light,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: EchnoColors.light,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.light,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: EchnoColors.light,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.light,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: EchnoColors.light,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: EchnoColors.light.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: EchnoColors.light),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: EchnoColors.light.withOpacity(0.5),
    ),
  );
}
