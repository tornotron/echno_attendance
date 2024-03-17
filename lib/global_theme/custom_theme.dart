import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/global_theme/button_style.dart';
import 'package:echno_attendance/global_theme/custom_app_bar.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* -- Theme Custom Classes -- */
class EchnoCustomTheme {
  EchnoCustomTheme._();

  /*-- Light Theme Data --*/

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: EchnoTextTheme.lightTextTheme,
    brightness: Brightness.light,
    disabledColor: EchnoColors.grey,
    primaryColor: EchnoColors.primary,
    scaffoldBackgroundColor: EchnoColors.white,
    appBarTheme: EchnoAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: EchnoElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EchnoOutlinedButtonTheme.lightOutlinedButtonTheme,
  );

  /*-- Light Theme Data --*/

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: EchnoTextTheme.darkTextTheme,
    fontFamily: GoogleFonts.inter().fontFamily,
    brightness: Brightness.dark,
    disabledColor: EchnoColors.grey,
    primaryColor: EchnoColors.secondary,
    scaffoldBackgroundColor: EchnoColors.black,
    appBarTheme: EchnoAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: EchnoElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: EchnoOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}
