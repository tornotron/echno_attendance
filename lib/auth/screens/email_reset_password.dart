import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as devtools show log;

class MailPasswordResetScreen extends StatefulWidget {
  const MailPasswordResetScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<MailPasswordResetScreen> createState() =>
      _MailPasswordResetScreenState();
}

class _MailPasswordResetScreenState extends State<MailPasswordResetScreen> {
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
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: MailPasswordResetScreen.containerPadding,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SvgPicture.asset(
                echnoPassword,
                height: height * 0.4,
              ),
              Column(
                children: [
                  Text(
                    'Forgot Password!',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please confirm your email address to reset your password...',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline),
                      labelText: 'Email ID',
                      hintText: 'E-Mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          (15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _controller.text.trim();
                        String errorMessage = '';
                        try {
                          await AuthService.firebase()
                              .resetPassword(toEmail: email);
                        } on GenericAuthException catch (e) {
                          if (e.message == 'user-not-found') {
                            errorMessage = 'No User Found!';
                            devtools.log('No user found for that email.');
                          } else if (e.message == 'invalid-email') {
                            errorMessage = 'Invalid Email!';
                            devtools.log('The email address is not valid.');
                          } else {
                            errorMessage = 'Something Went Wrong!';
                            devtools.log(e.message);
                          }
                        }
                        if (errorMessage.isNotEmpty) {
                          await showErrorDialog(context, errorMessage);
                        } else {
                          resetPasswordAlert(context);
                        }
                      },
                      child: const Text(
                        'Reset Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
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
