import 'package:echno_attendance/common_widgets/loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:echno_attendance/auth/services/index.dart';
import 'package:echno_attendance/auth/screens/index.dart';
import 'package:echno_attendance/constants/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Initialize Firebase and the Flutter app.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EchnoTestApp());
}

class EchnoTestApp extends StatelessWidget {
  const EchnoTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const NewEchnoHomePage(),
      ),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class NewEchnoHomePage extends StatefulWidget {
  const NewEchnoHomePage({super.key});

  @override
  State<NewEchnoHomePage> createState() => _NewEchnoHomePageState();
}

class _NewEchnoHomePageState extends State<NewEchnoHomePage> {
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
