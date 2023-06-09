import 'package:echno_attendance/constants/image_string.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: height,
            padding: containerPadding,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*-----------------Welcome Header Start -----------------*/

                  SvgPicture.asset(
                    echnoLogo,
                  ),
                  Text(
                    'Welcome to Echno!',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Unlock the potential of effective attendance tracking and progress monitoring!',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  /*-----------------Welcome Header End -----------------*/

                  /*-----------------Welcome Button Start -----------------*/

                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 17.0, fontFamily: 'TT Chocolates'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 17.0, fontFamily: 'TT Chocolates'),
                      ),
                    ),
                  ),

                  /*-----------------Welcome Button End -----------------*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
