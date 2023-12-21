import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/utilities/index.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/auth/widgets/password_form_field.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer' as devtools show log;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  late final TextEditingController _employeeIdController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _employeeIdController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthRegistrationState) {
            if (state.exception is WeakPasswordAuthException) {
              devtools.log('The password provided is too weak');
              await showErrorDialog(context, 'Weak Password..!');
            } else if (state.exception is EmailAlreadyInUseAuthException) {
              devtools.log('The account already exists for that email.');
              await showErrorDialog(context, 'Email Already in Use..!');
            } else if (state.exception is InvalidEmailAuthException) {
              devtools.log('The email address is not valid.');
              await showErrorDialog(context, 'Invalid Email..!');
            } else if (state.exception is GenericAuthException) {
              devtools.log(state.exception.toString());
              await showErrorDialog(context, 'Failed to Register..!');
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: RegistrationScreen.containerPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*---------- Register Screen Header Start ----------*/

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          echnoRegister,
                          height: height * 0.15,
                        ),
                        const SizedBox(height: 15.0),
                        Text('Get On Board!',
                            style: Theme.of(context).textTheme.displaySmall),
                        Text(
                          'Create an account to start your Journey ...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),

                    /*---------- Register Screen Header End ----------*/

                    /*---------- Register Screen Form Start ----------*/

                    Form(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Employee ID TextField
                            TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.person_outline_outlined),
                                labelText: 'Employee ID',
                                hintText: 'EMP-000001',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    (15.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            // // Full Name TextField
                            // TextFormField(
                            //   maxLines: 1,
                            //   decoration: InputDecoration(
                            //     prefixIcon:
                            //         const Icon(Icons.person_outline_outlined),
                            //     labelText: 'Full Name',
                            //     hintText: 'Full Name',
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(
                            //         (15.0),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 10.0),

                            // Email TextField
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
                                prefixIcon:
                                    const Icon(Icons.person_outline_outlined),
                                labelText: 'Email ID',
                                hintText: 'E-Mail',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),

                            // // Mobile Number TextField
                            // TextFormField(
                            //   controller: phoneController,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       phoneController.text = value;
                            //     });
                            //   },
                            //   enableSuggestions: false,
                            //   autocorrect: false,
                            //   keyboardType: TextInputType.number,
                            //   maxLines: 1,
                            //   decoration: InputDecoration(
                            //     labelText: 'Mobile Number',
                            //     hintText: '1234 567 890',
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15.0),
                            //     ),
                            //     prefixIcon: Container(
                            //       padding: const EdgeInsets.all(13.5),
                            //       child: InkWell(
                            //         onTap: () {
                            //           showCountryPicker(
                            //             context: context,
                            //             countryListTheme:
                            //                 const CountryListThemeData(
                            //               bottomSheetHeight: 550,
                            //             ),
                            //             onSelect: (value) {
                            //               setState(() {
                            //                 selectedCountry = value;
                            //               });
                            //             },
                            //           );
                            //         },
                            //         child: Text(
                            //           "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            //           style:
                            //               Theme.of(context).textTheme.titleMedium,
                            //         ),
                            //       ),
                            //     ),
                            //     suffixIcon: phoneController.text.length > 9
                            //         ? Container(
                            //             height: 30,
                            //             width: 30,
                            //             margin: const EdgeInsets.all(10.0),
                            //             decoration: const BoxDecoration(
                            //               shape: BoxShape.circle,
                            //               color: Colors.green,
                            //             ),
                            //             child: const Icon(
                            //               Icons.done,
                            //               color: Colors.white,
                            //               size: 20,
                            //             ),
                            //           )
                            //         : null,
                            //   ),
                            // ),
                            // const SizedBox(height: 10.0),

                            // Password TextField
                            PasswordTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 10.0),

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
                                  // final employeeID = _employeeIdController.text;
                                  final email = _emailController.text;
                                  final password = _passwordController.text;

                                  context.read<AuthBloc>().add(
                                        AuthRegistrationEvent(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                  verificationMailAltert(context);
                                },
                                child: const Text(
                                  'REGISTER',
                                ),
                              ),
                            ),

                            /*---------- Register Screen Form End ----------*/
                          ],
                        ),
                      ),
                    ),

                    /*---------- Register Screen Footer Start ----------*/

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
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  const AuthLogOutEvent(),
                                );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account ? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                  text: 'Login',
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

                    /*---------- Register Screen Footer End ----------*/
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
