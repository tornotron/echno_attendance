import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  final String appbarUserName;

  const HomePage({super.key, required this.appbarUserName});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Color(0xFF004AAD)),
          leading: const Icon(
            Icons.account_circle_rounded,
            size: 35,
          ),
          actions: [
            Center(
              child: Text(
                appbarUserName,
                style: const TextStyle(
                    fontFamily: 'TT Chocolates',
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
          backgroundColor: const Color(0xFF004AAD),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          color: Color(0xFF004AAD),
          items: [
            Container(
              child: Image.asset(
                'assets/icons/5.png',
                scale: 50,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/icons/7.png',
                scale: 50,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/icons/10.png',
                scale: 50,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/icons/11.png',
                scale: 50,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/icons/13.png',
                scale: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
