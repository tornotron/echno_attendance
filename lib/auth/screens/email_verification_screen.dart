import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(50.0),
                  child: SvgPicture.asset(
                    echnoEmailVerification,
                    height: 200.0,
                  ),
                ),
                const SizedBox(height: EchnoSize.spaceBtwSections),
                Text(
                  'Email Verification',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: EchnoSize.spaceBtwItems / 2),
                Text(
                  'Please click on the link you\'ve received via your email...',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: EchnoSize.spaceBtwSections),
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
                const SizedBox(height: EchnoSize.spaceBtwItems),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthLogOutEvent(),
                        );
                  },
                  child: Text('Back to Login',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDark
                                ? EchnoColors.secondary
                                : EchnoColors.primary,
                          )),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
