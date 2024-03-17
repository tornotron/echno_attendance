import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreenFooter extends StatelessWidget {
  const LoginScreenFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Divider(
                color: isDark ? EchnoColors.darkGrey : EchnoColors.grey,
                thickness: 0.5,
                indent: 60.0,
                endIndent: 5.0,
              ),
            ),
            const Text('OR'),
            Flexible(
              child: Divider(
                color: isDark ? EchnoColors.darkGrey : EchnoColors.grey,
                thickness: 0.5,
                indent: 5.0,
                endIndent: 60.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: SvgPicture.asset(
                googleIcon,
                width: 20.0,
              ),
              onPressed: () async {
                await genericAlertDialog(
                    context, 'Sorry this feature is currently disabled...');
              },
              label: const Text(
                'Sign-In with Google',
              )),
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Icon(Icons.mobile_friendly_outlined),
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthPhoneLogInInitiatedEvent(),
                    );
              },
              label: const Text(
                'Sign-In with Phone',
              )),
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const AuthNeedToRegisterEvent(),
                );
          },
          child: Text.rich(
            TextSpan(
              text: 'Don\'t have an account ? ',
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Register',
                  style: TextStyle(
                      color:
                          isDark ? EchnoColors.secondary : EchnoColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
