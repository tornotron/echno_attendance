import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/image_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
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
          body: SingleChildScrollView(
        child: Padding(
          padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(50.0),
                child: SvgPicture.asset(
                  EchnoImages.emailVerification,
                  height: EchnoSize.imageHeaderHeightLg,
                ),
              ),
              const SizedBox(height: EchnoSize.spaceBtwSections),
              Text(
                EchnoText.emailVerificationTitle,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: EchnoSize.spaceBtwItems / 2),
              Text(
                EchnoText.emailVerificationSubtitle,
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
                    EchnoText.emailVerificationButton,
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
                child: Text(
                  EchnoText.backToLogin,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isDark
                            ? EchnoColors.secondary
                            : EchnoColors.primary,
                      ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
