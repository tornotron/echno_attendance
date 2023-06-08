import 'package:echno_attendance/firebase_options.dart';
import 'package:echno_attendance/routes.dart';
import 'package:echno_attendance/utilities/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
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
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        devtools.log(userCredential.toString());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          devtools.log('The password provided is too weak.');
                          await showErrorDialog(
                            context,
                            'Weak Password',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          devtools.log(
                              'The account already exists for that email.');
                          await showErrorDialog(
                            context,
                            'Email Already in Use',
                          );
                        } else if (e.code == 'invalid-email') {
                          devtools.log('The email address is not valid.');
                          await showErrorDialog(
                            context,
                            'Invalid Email',
                          );
                        } else {
                          devtools.log(e.code);
                          await showErrorDialog(
                            context,
                            'Error: ${e.code}',
                          );
                        }
                      } catch (e) {
                        devtools.log(e.runtimeType.toString());
                        await showErrorDialog(
                          context,
                          'Error: ${e.toString()}',
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
