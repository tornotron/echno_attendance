import 'package:echno_attendance/screens/login_screen.dart';
import 'package:echno_attendance/screens/register_screen.dart';
import 'package:echno_attendance/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

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
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/verify_email/': (context) => const VerifyEmailView(),
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
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const LoginView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const Text("Welcome to Echno!");
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
