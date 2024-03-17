import 'package:country_picker/country_picker.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/utilities/index.dart';
import 'package:echno_attendance/auth/widgets/registration_widgets/registration_footer.dart';
import 'package:echno_attendance/auth/widgets/registration_widgets/registration_form.dart';
import 'package:echno_attendance/auth/widgets/registration_widgets/registration_header.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _employeeIdController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _employeeIdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _employeeIdController.dispose();
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
    final isDark = EchnoHelperFunctions.isDarkMode(context);
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
              child: Padding(
                padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section Widget
                    const RegistrationScreenHeader(),
                    const SizedBox(height: EchnoSize.spaceBtwSections),
                    // Form Section Widget
                    RegistrationForm(
                      registrationFormKey: _registrationFormKey,
                      employeeIdController: _employeeIdController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: EchnoSize.spaceBtwSections),
                    // Footer Section Widget
                    RegistrationScreenFooter(isDark: isDark),
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
