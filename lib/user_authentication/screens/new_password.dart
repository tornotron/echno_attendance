import 'package:echno_attendance/user_authentication/widgets/password_form_field.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                children: [
                  Text('Reset Password',
                      style: Theme.of(context).textTheme.displaySmall),
                  Text(
                    'Please enter a new password...',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  const PasswordTextField(
                    labelText: 'New Password',
                    hintText: 'New Password',
                  ),
                  const SizedBox(height: 15.0),
                  const PasswordTextField(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 17.0, fontFamily: 'TT Chocolates'),
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
