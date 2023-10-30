import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/phone_auth/screens/phone_otp_verification.dart';
import 'package:echno_attendance/phone_auth/services/auth_cubits.dart';
import 'package:echno_attendance/phone_auth/services/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController phoneController = TextEditingController();

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
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: PhoneLoginScreen.containerPadding,
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: phoneController,
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                hintText: '1234 567 890',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(13.5),
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme:
                                            const CountryListThemeData(
                                          bottomSheetHeight: 550,
                                        ),
                                        onSelect: (value) {
                                          setState(() {
                                            selectedCountry = value;
                                          });
                                        },
                                      );
                                    },
                                    child: Text(
                                      "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                                suffixIcon: phoneController.text.length > 9
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    : null,
                              ),
                            ),

                            /*---------- Login Form End ----------*/

                            /*---------- Login Form Buttons Start ----------*/
                            const SizedBox(height: 20.0),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthCodeSentState) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneOTPVerification()));
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String phoneNumber =
                                          "+${selectedCountry.phoneCode}${phoneController.text.trim()}";
                                      BlocProvider.of<AuthCubit>(context)
                                          .sendOTP(phoneNumber);
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: 'TT Chocolates'),
                                    ),
                                  ),
                                );
                              },
                            ),

                            /*---------- Login Form Buttons End ----------*/
                          ],
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
                                )),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                                icon: const Icon(Icons.email_rounded),
                                onPressed: () {},
                                label: const Text(
                                  'Login with Email',
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
