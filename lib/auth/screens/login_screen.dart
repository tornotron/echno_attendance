import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/utilities/index.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/auth/widgets/password_form_field.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer' as devtools show log;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoggedOutState) {
            if (state.exception is UserNotFoundAuthException) {
              devtools.log('No user found for that email.');
              await showErrorDialog(context, 'User Not Found');
            } else if (state.exception is WrongPasswordAuthException) {
              devtools.log('Wrong password provided for that user.');
              await showErrorDialog(context, 'Wrong Credentials');
            } else if (state.exception is GenericAuthException) {
              devtools.log(state.exception.toString());
              await showErrorDialog(context, 'Authentication Error');
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: LoginScreen.containerPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*---------- Login Header Start ----------*/

                        SvgPicture.asset(
                          echnoSignIn,
                          height: height * 0.15,
                        ),
                        const SizedBox(height: 15.0),
                        Text('Welcome Back,',
                            style: Theme.of(context).textTheme.displaySmall),
                        Text(
                          'Login to streamline your workday...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        /*---------- Login Header End ----------*/

                        /*---------- Login Form Start ----------*/

                        const SizedBox(height: 50.0),
                        Form(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                                    // filled: true,
                                    // fillColor:
                                    // const Color.fromARGB(255, 214, 214, 214),
                                    prefixIcon: const Icon(
                                        Icons.person_outline_outlined),
                                    labelText: 'Email ID',
                                    hintText: 'E-Mail',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                PasswordTextField(
                                  controller: _passwordController,
                                  labelText: 'Password',
                                  hintText: 'Password',
                                ),

                                /*---------- Login Form End ----------*/

                                /*---------- Login Form Buttons Start ----------*/

                                const SizedBox(height: 10.0),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      /*---------- Forgot Password BottomSheet Start ----------*/

                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        context: context,
                                        builder: (builderContext) =>
                                            SingleChildScrollView(
                                          child: Container(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Reset Password!',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                                Text(
                                                  'Choose an option to reset your password...',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                const SizedBox(
                                                  height: 30.0,
                                                ),
                                                // Email Password Reset

                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(
                                                          const AuthForgotPasswordEvent(),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: echnoGreyColor,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .mail_outline_outlined,
                                                          size: 60.0,
                                                        ),
                                                        const SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'E-Mail',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                            ),
                                                            Text(
                                                              'Reset via E-Mail Verification',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                                // Phone Password Reset

                                                // GestureDetector(
                                                //   onTap: () {},
                                                //   child: Container(
                                                //     padding: const EdgeInsets.all(
                                                //         20.0),
                                                //     decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               15.0),
                                                //       color: echnoGreyColor,
                                                //     ),
                                                //     child: Row(
                                                //       children: [
                                                //         const Icon(
                                                //           Icons
                                                //               .mobile_friendly_rounded,
                                                //           size: 60.0,
                                                //         ),
                                                //         const SizedBox(
                                                //           width: 10.0,
                                                //         ),
                                                //         Column(
                                                //           crossAxisAlignment:
                                                //               CrossAxisAlignment
                                                //                   .start,
                                                //           children: [
                                                //             Text(
                                                //               'Phone Number',
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .titleLarge,
                                                //             ),
                                                //             Text(
                                                //               'Reset via Phone Verification',
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .titleSmall,
                                                //             )
                                                //           ],
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'TT Chocolates',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      context.read<AuthBloc>().add(
                                            AuthLogInEvent(
                                              email: email,
                                              password: password,
                                            ),
                                          );
                                    },
                                    child: const Text(
                                      'LOGIN',
                                    ),
                                  ),
                                ),

                                /*---------- Login Form Buttons End ----------*/
                              ],
                            ),
                          ),
                        ),

                        /*---------- Login Screen Footer Start ----------*/

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('OR'),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  icon: SvgPicture.asset(
                                    googleIcon,
                                    width: 20.0,
                                  ),
                                  onPressed: () async {
                                    await genericAlertDialog(context,
                                        'Sorry this feature is currently disabled...');
                                  },
                                  label: const Text(
                                    'Sign-In with Google',
                                  )),
                            ),
                            const SizedBox(height: 15.0),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  icon: const Icon(
                                      Icons.mobile_friendly_outlined),
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                          const AuthPhoneLogInInitiatedEvent(),
                                        );
                                  },
                                  label: const Text(
                                    'Sign-In with Phone',
                                  )),
                            ),
                            const SizedBox(height: 10.0),
                            TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      const AuthNeedToRegisterEvent(),
                                    );
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'Don\'t have an account ? ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  children: const [
                                    TextSpan(
                                      text: 'Register',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        /*---------- Login Screen Footer End ----------*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
