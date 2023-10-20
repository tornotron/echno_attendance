import 'package:echno_attendance/constants/custom_theme.dart';
import 'package:echno_attendance/phone_auth/screens/home_screen.dart';
import 'package:echno_attendance/phone_auth/screens/phone_login.dart';
import 'package:echno_attendance/phone_auth/services/auth_cubits.dart';
import 'package:echno_attendance/phone_auth/services/auth_states.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Initialize Firebase and the Flutter app.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EchnoTestApp());
}

class EchnoTestApp extends StatelessWidget {
  const EchnoTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: EchnoCustomTheme.lightTheme,
        darkTheme: EchnoCustomTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const HomeScreen();
            } else if (state is AuthLoggedOutState) {
              return const PhoneLoginScreen();
            } else {
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
