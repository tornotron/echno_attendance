import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/widgets/password_form_field.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({
    super.key,
    required GlobalKey<FormState> registrationFormKey,
    required TextEditingController employeeIdController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _registrationFormKey = registrationFormKey,
        _employeeIdController = employeeIdController,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _registrationFormKey;
  final TextEditingController _employeeIdController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registrationFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employee ID TextField
          TextFormField(
            controller: _employeeIdController,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline_outlined),
              labelText: 'Employee ID',
              hintText: 'EMP-000001',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  (15.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: EchnoSize.spaceBtwInputFields),

          // Email TextField
          TextFormField(
            controller: _emailController,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline_outlined),
              labelText: 'Email ID',
              hintText: 'E-Mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email cannot be empty";
              }
              return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)
                  ? null
                  : "Please enter a valid email";
            },
          ),
          const SizedBox(height: EchnoSize.spaceBtwInputFields),

          // Password TextField
          PasswordTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              } else if (value.length < 6) {
                return "Password must be at least 6 characters";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: EchnoSize.spaceBtwItems),

          // // Re-Enter Password TextField
          // const PasswordTextField(
          //   labelText: 'Re-Enter Password',
          //   hintText: 'Re-Enter Password',
          // ),
          // const SizedBox(height: 30.0),

          // Register Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_registrationFormKey.currentState!.validate()) {
                  final String email = _emailController.text;
                  final String password = _passwordController.text;
                  final String? employeeId = _employeeIdController.text.isEmpty
                      ? null
                      : _employeeIdController.text;

                  context.read<AuthBloc>().add(
                        AuthRegistrationEvent(
                          employeeId,
                          authUserEmail: email,
                          password: password,
                        ),
                      );
                  verificationMailAltert(context);
                }
              },
              child: const Text(
                'REGISTER',
              ),
            ),
          ),

          /*---------- Register Screen Form End ----------*/
        ],
      ),
    );
  }
}
