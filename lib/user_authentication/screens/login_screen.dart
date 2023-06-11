import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/user_authentication/widgets/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
                              const SizedBox(height: 15.0),
                              const PasswordTextField(
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
                                      builder: (context) => Container(
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
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20.0),
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                        ),
                                                        Text(
                                                          'Reset via E-Mail Verification',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            // Phone Password Reset
                                          ],
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
                                  onPressed: () {},
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontFamily: 'TT Chocolates'),
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
                                onPressed: () {},
                                label: const Text(
                                  'Sign-In with Google',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'TT Chocolates'),
                                )),
                          ),
                          const SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {},
                            child: Text.rich(
                              TextSpan(
                                text: 'Don\'t have an account ? ',
                                style: Theme.of(context).textTheme.titleMedium,
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
    );
  }
}
