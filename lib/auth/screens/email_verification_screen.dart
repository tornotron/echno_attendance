import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});
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
            padding: containerPadding,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(50.0),
                child: SvgPicture.asset(
                  echnoEmailVerification,
                  height: height * 0.3,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Email Verification',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please click on the link you\'ve received via your email...',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        devtools.log('Verification Mail Sent...!');
                        context.read<AuthBloc>().add(
                              const AuthVerifyEmailEvent(),
                            );
                      },
                      child: const Text(
                        'Resent Verification Mail',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthLogOutEvent(),
                          );
                    },
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                        fontFamily: 'TT Chocolates',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      )),
    );
  }
}
