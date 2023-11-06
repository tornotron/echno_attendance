import 'package:echno_attendance/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MailOTPVerification extends StatelessWidget {
  const MailOTPVerification({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final TextEditingController otpController = TextEditingController();

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
                echnoOTP,
                height: height * 0.4,
              ),
              Column(
                children: [
                  Text(
                    'OTP Verification',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please enter the OTP you\'ve received via your email...',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  TextFormField(
                    controller: otpController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timer_rounded),
                      labelText: '6-Digit OTP',
                      hintText: '6-Digit OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          (15.0),
                        ),
                      ),
                    ),
                  ),
                  // OtpTextField(
                  //   numberOfFields: 6,
                  //   borderColor: Theme.of(context).primaryColor,
                  //   showFieldAsBox: true,
                  //   onCodeChanged: (String code) {},
                  //   onSubmit: (String verificationCode) {},
                  // ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Confirm',
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
