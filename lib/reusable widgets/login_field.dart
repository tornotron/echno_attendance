import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hint;
  final double width;
  const LoginField({super.key, required this.hint, this.width = 300});

  @override
  Widget build(context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color.fromARGB(255, 214, 214, 214),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
