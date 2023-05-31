import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String appbarUserName;

  const HomePage({super.key, required this.appbarUserName});

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.account_circle_rounded,
            size: 35,
          ),
          actions: [
            Center(
              child: Text(
                appbarUserName,
                style: TextStyle(
                    fontFamily: 'TT Chocolates',
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
          backgroundColor: const Color(0xFF004AAD),
        ),
      ),
    );
  }
}
