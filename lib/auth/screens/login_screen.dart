import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/utilities/index.dart';
import 'package:echno_attendance/auth/widgets/login_widgets/login_form.dart';
import 'package:echno_attendance/auth/widgets/login_widgets/login_screen_footer.dart';
import 'package:echno_attendance/constants/image_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/constants/static_text.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer' as devtools show log;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
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
          body: SingleChildScrollView(
            child: Padding(
              padding: CustomPaddingStyle.defaultPaddingWithoutAppbar,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
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
                  // Login Form Widget
                  LoginFormWidget(
                    loginFormKey: _loginFormKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: EchnoSize.spaceBtwSections),
                  // Footer Section Widget
                  const LoginScreenFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
