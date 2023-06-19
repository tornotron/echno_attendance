import 'package:echno_attendance/utilities/routes.dart';
import 'package:echno_attendance/user/views/homepage_screen.dart';
import 'package:echno_attendance/auth/views/login_screen.dart';
import 'package:echno_attendance/auth/views/register_screen.dart';
import 'package:echno_attendance/auth/views/verify_email_screen.dart';
import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class EchnoApp extends StatelessWidget {
  const EchnoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EchnoHomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        homeRoute: (context) => const HomePageView(),
      },
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
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isemailVerified) {
                return const HomePageView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
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
