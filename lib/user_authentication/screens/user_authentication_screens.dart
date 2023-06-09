import 'package:echno_attendance/constants/custom_theme.dart';
import 'package:echno_attendance/user_authentication/screens/wecome_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      // darkTheme: CustomTheme.darkTheme,
      // themeMode: ThemeMode.system,
    );
  }
}
