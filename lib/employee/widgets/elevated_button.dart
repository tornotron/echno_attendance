import 'package:echno_attendance/global_theme/text_theme.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String buttonName;
  final double buttonWidth;
  final double buttonRadius;

  const LoginButton({
    super.key,
    required this.buttonName,
    this.buttonWidth = 300,
    required this.buttonRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 50),
          backgroundColor: const Color(0xFF004AAD),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(buttonRadius),
            ),
          ),
        ),
        onPressed: () {},
        child: Text(
          buttonName,
          style: EchnoTextTheme.darkTextTheme.titleLarge,
        ),
      ),
    );
  }
}
