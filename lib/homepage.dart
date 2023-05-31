import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  final String appbarUserName;

  const HomePage({super.key, required this.appbarUserName});

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Color(0xFF004AAD)),
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
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: const Color(0xFF004AAD),
        ),
      ),
    );
  }
}
