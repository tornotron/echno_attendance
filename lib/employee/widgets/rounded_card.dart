import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
// import 'package:echno_attendance/reusable widgets/texts.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: screenHeight / 4,
      width: screenWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        color: isDark ? EchnoColors.secondaryDark : EchnoColors.primaryLight,
        child: const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //  Texts(
              //     textData: 'Welcome',
              //     textFontSize: 28,
              //   ),
              // SizedBox(
              //   height: 20,
              // ),
              // Texts(
              //   textData: 'Site Name',
              // ),
              // SizedBox(
              //   height: 2.5,
              // ),
              // Texts(
              //   textData: 'Site Location',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
