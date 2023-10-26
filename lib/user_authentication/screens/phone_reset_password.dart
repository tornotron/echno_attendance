import 'package:echno_attendance/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhonePasswordResetScreen extends StatelessWidget {
  const PhonePasswordResetScreen({super.key});
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
            padding: containerPadding,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SvgPicture.asset(
                echnoPassword,
                height: height * 0.5,
              ),
              Column(
                children: [
                  Text(
                    'Forgot Password!',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please confirm your phone number to reset your password...',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android_rounded),
                      labelText: 'Phone Number',
                      hintText: '+1-1234567890',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          (15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Next',
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
