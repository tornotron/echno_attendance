import 'package:echno_attendance/auth/screens/index.dart';
import 'package:echno_attendance/constants/custom_theme.dart';
import 'package:echno_attendance/utilities/routes.dart';
import 'package:echno_attendance/auth/services/auth_service.dart';
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
      home: const NewEchnoHomePage(),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegistrationScreen(),
        verifyEmailRoute: (context) => const EmailVerification(),
        homeRoute: (context) => const HomeScreen(),
        resetPasswordRoute: (context) => const MailPasswordResetScreen(),
      },
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
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isemailVerified) {
                return const HomeScreen();
              } else {
                return const EmailVerification();
              }
            } else {
              return const LoginScreen();
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
