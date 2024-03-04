import 'package:echno_attendance/common_widgets/loading_screen.dart';
import 'package:echno_attendance/global_theme/custom_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/services/index.dart';
import 'package:echno_attendance/auth/screens/index.dart';
import 'package:flutter/material.dart';

class EchnoApp extends StatelessWidget {
  const EchnoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthHandler()),
        child: const EchnoHomePage(),
      ),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class EchnoHomePage extends StatefulWidget {
  const EchnoHomePage({super.key});

  @override
  State<EchnoHomePage> createState() => _EchnoHomePageState();
}

class _EchnoHomePageState extends State<EchnoHomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthInitializeEvent());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
            context: context,
            text: state.loadingMessage ?? 'Please wait a while...');
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is AuthLoggedInState) {
        return const HomeScreen();
      } else if (state is AuthEmailNotVerifiedState) {
        return const EmailVerification();
      } else if (state is AuthLoggedOutState) {
        return const LoginScreen();
      } else if (state is AuthForgotPasswordState) {
        return const MailPasswordResetScreen();
      } else if (state is AuthRegistrationState) {
        return const RegistrationScreen();
      } else if (state is AuthPhoneLogInInitiatedState) {
        return const PhoneLoginScreen();
      } else {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
