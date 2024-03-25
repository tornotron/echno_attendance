import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/image_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
import 'package:echno_attendance/utilities/helpers/form_validators.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final GlobalKey<FormState> _phoneLoginFormKey = GlobalKey<FormState>();
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
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      EchnoImages.signIn,
                      height: EchnoSize.imageHeaderHeightMd,
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwItems),
                    Text(EchnoText.loginTitle,
                        style: Theme.of(context).textTheme.displaySmall),
                    Text(
                      EchnoText.loginSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwSections),

                    // Phone Login Form Widget
                    Form(
                      key: _phoneLoginFormKey,
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
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                                        color: EchnoColors.success,
                                      ),
                                      child: const Icon(
                                        Icons.done,
                                        color: EchnoColors.white,
                                        size: 20,
                                      ),
                                    )
                                  : null,
                            ),
                            validator: (value) =>
                                EchnoValidator.validatePhoneNumber(value),
                          ),
                          const SizedBox(height: EchnoSize.spaceBtwItems),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_phoneLoginFormKey.currentState!
                                    .validate()) {
                                  await genericAlertDialog(
                                      context, EchnoText.featureDisabled);
                                }
                              },
                              child: const Text(
                                EchnoText.loginButton,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwSections),
                    // Footer Section Widget

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Divider(
                                color: isDark
                                    ? EchnoColors.darkGrey
                                    : EchnoColors.grey,
                                thickness: 0.5,
                                indent: 60.0,
                                endIndent: 5.0,
                              ),
                            ),
                            const Text('OR'),
                            Flexible(
                              child: Divider(
                                color: isDark
                                    ? EchnoColors.darkGrey
                                    : EchnoColors.grey,
                                thickness: 0.5,
                                indent: 5.0,
                                endIndent: 60.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwItems),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                              icon: SvgPicture.asset(
                                EchnoImages.googleIcon,
                                width: EchnoSize.imageButtonWidth,
                              ),
                              onPressed: () async {
                                await genericAlertDialog(
                                    context, EchnoText.featureDisabled);
                              },
                              label: const Text(
                                EchnoText.googleButton,
                              )),
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwItems),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                              icon: const Icon(Icons.email_rounded),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      const AuthLogOutEvent(),
                                    );
                              },
                              label: const Text(
                                EchnoText.emailButton,
                              )),
                        ),
                        const SizedBox(height: EchnoSize.spaceBtwItems),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  const AuthNeedToRegisterEvent(),
                                );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: EchnoText.loginFooter,
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                      color: isDark
                                          ? EchnoColors.secondary
                                          : EchnoColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
