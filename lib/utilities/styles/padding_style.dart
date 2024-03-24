import 'package:echno_attendance/constants/sizes.dart';
import 'package:flutter/widgets.dart';

class CustomPaddingStyle {
  static const EdgeInsetsGeometry defaultPaddingWithoutAppbar = EdgeInsets.only(
    top: EchnoSize.appBarHeight,
    bottom: EchnoSize.defaultSpace,
    left: EchnoSize.defaultSpace,
    right: EchnoSize.defaultSpace,
  );

  static const EdgeInsetsGeometry defaultPaddingWithAppbar =
      EdgeInsets.symmetric(
    vertical: EchnoSize.lg,
    horizontal: EchnoSize.lg,
  );
}
