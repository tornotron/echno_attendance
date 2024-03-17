import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:flutter/material.dart';

class EchnoAppBarTheme {
  EchnoAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: EchnoColors.primary,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: EchnoColors.black, size: EchnoSize.iconMd),
    actionsIconTheme:
        IconThemeData(color: EchnoColors.black, size: EchnoSize.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: EchnoColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: EchnoColors.secondary,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: EchnoColors.black, size: EchnoSize.iconMd),
    actionsIconTheme:
        IconThemeData(color: EchnoColors.white, size: EchnoSize.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: EchnoColors.white),
  );
}
