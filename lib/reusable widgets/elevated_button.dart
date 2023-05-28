import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String buttonName;
  const LoginButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(300, 50),
        backgroundColor: Color(0xFF004AAD),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(buttonName),
    );
  }
}
