import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/auth/widgets/forgot_password_form.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

class MailPasswordResetScreen extends StatefulWidget {
  const MailPasswordResetScreen({super.key});

  @override
  State<MailPasswordResetScreen> createState() =>
      _MailPasswordResetScreenState();
}

class _MailPasswordResetScreenState extends State<MailPasswordResetScreen> {
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthForgotPasswordState) {
            if (state.hasSentEmail) {
              devtools.log('Email Sent Successfully!');
              _controller.clear();
              resetPasswordAlert(context);
            }
            if (state.exception is InvalidEmailAuthException) {
              devtools.log('The email address is not valid.');
              showErrorDialog(context, 'Invalid Email!');
            } else if (state.exception is UserNotFoundAuthException) {
              devtools.log('No user found for that email.');
              showErrorDialog(context, 'No User Found!');
            } else if (state.exception is GenericAuthException) {
              devtools.log(state.exception.toString());
              showErrorDialog(context, 'Something Went Wrong!');
            }
          }
        },
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SvgPicture.asset(
                  echnoPassword,
                  height: 200.0,
                ),
                const SizedBox(height: EchnoSize.spaceBtwSections),
                Column(
                  children: [
                    Text(
                      'Forgot Password!',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwItems / 2),
                    Text(
                      'Please confirm your email address to reset your password...',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: EchnoSize.spaceBtwItems),
                // Form Section Widget
                ForgotPasswordForm(
                  forgotPasswordFormKey: _forgotPasswordFormKey,
                  controller: _controller,
                  isDark: isDark,
                ),
              ]),
            ),
          ),
        )),
      ),
    );
  }
}
