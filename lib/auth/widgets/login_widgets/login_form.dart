import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/widgets/login_widgets/forgot_password_widget.dart';
import 'package:echno_attendance/auth/widgets/password_form_field.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
import 'package:echno_attendance/utilities/helpers/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({
    super.key,
    required GlobalKey<FormState> loginFormKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _loginFormKey = loginFormKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _loginFormKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                borderRadius: BorderRadius.circular(EchnoSize.borderRadiusLg),
              ),
            ),
            validator: (value) => EchnoValidator.validateEmail(value),
          ),
          const SizedBox(height: EchnoSize.spaceBtwInputFields),
          PasswordTextField(
            controller: _passwordController,
            labelText: 'Password',
            hintText: 'Password',
            validator: (value) => EchnoValidator.validatePassword(value),
          ),
          const SizedBox(height: EchnoSize.spaceBtwItems / 2),
          const ForgotPasswordWidget(),
          const SizedBox(height: EchnoSize.spaceBtwItems / 2),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_loginFormKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context.read<AuthBloc>().add(
                        AuthLogInEvent(
                          authUserEmail: email,
                          password: password,
                        ),
                      );
                }
              },
              child: const Text(
                EchnoText.loginButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
