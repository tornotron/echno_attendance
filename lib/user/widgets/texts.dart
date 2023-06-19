import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final String textData;
  final double textFontSize;

  const Texts({
    super.key,
    required this.textData,
    this.textFontSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'TT Chocolates',
        fontSize: textFontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
