import 'package:echno_attendance/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: height,
              padding: containerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*---------- Login Header Start ----------*/

                      SvgPicture.asset(
                        echnoSignIn,
                        height: height * 0.15,
                      ),
                      const SizedBox(height: 15.0),
                      Text('Welcome Back,',
                          style: Theme.of(context).textTheme.displaySmall),
                      Text(
                        'Login to streamline your workday...',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      /*---------- Login Header End ----------*/
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
