import 'package:echno_attendance/utilities/routes.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:echno_attendance/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Echno'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      try {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        if (context.mounted) {
                          Navigator.of(context).pushNamed(
                            verifyEmailRoute,
                          );
                        }
                        await AuthService.firebase().sendEmailVerification();
                      } on WeakPasswordAuthException {
                        devtools.log('The password provided is too weak.');
                        await showErrorDialog(
                          context,
                          'Weak Password',
                        );
                      } on EmailAlreadyInUseAuthException {
                        devtools
                            .log('The account already exists for that email.');
                        await showErrorDialog(
                          context,
                          'Email Already in Use',
                        );
                      } on InvalidEmailAuthException {
                        devtools.log('The email address is not valid.');
                        await showErrorDialog(
                          context,
                          'Invalid Email',
                        );
                      } on GenericAuthException catch (e) {
                        await showErrorDialog(
                          context,
                          'Error: $e',
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Already Registered? Login here!'),
                  )
                ],
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
