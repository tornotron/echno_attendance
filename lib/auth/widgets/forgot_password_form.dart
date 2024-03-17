import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required GlobalKey<FormState> forgotPasswordFormKey,
    required TextEditingController controller,
    required this.isDark,
  })  : _forgotPasswordFormKey = forgotPasswordFormKey,
        _controller = controller;

  final GlobalKey<FormState> _forgotPasswordFormKey;
  final TextEditingController _controller;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _forgotPasswordFormKey,
      child: Column(
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
          const SizedBox(height: EchnoSize.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_forgotPasswordFormKey.currentState!.validate()) {
                  final email = _controller.text.trim();
                  context.read<AuthBloc>().add(
                        AuthForgotPasswordEvent(
                          authUserEmail: email,
                        ),
                      );
                }
              },
              child: const Text(
                'Reset Password',
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
                      color:
                          isDark ? EchnoColors.secondary : EchnoColors.primary,
                    )),
          ),
        ],
      ),
    );
  }
}
