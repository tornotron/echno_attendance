import 'package:echno_attendance/global_theme/custom_theme.dart';
import 'package:echno_attendance/user/hr_screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() async {
  // Initialize Firebase and the Flutter app.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EchnoTestApp());
}

class EchnoTestApp extends StatelessWidget {
  const EchnoTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HRDashboardScreen(),
      theme: EchnoCustomTheme.lightTheme,
      darkTheme: EchnoCustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
