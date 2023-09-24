import 'package:echno_attendance/constants/custom_theme.dart';
import 'package:echno_attendance/user_authentication/screens/registration_screen.dart';
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
      home: const RegistrationScreen(),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
