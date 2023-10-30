import 'package:echno_attendance/phone_auth/screens/phone_login.dart';
import 'package:echno_attendance/phone_auth/services/auth_cubits.dart';
import 'package:echno_attendance/phone_auth/services/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(context) {
    // final mediaQuery = MediaQuery.of(context);
    // final height = mediaQuery.size.height;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: HomeScreen.containerPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /*-----------------Welcome Header Start -----------------*/

                Text(
                  'Home Screen',
                  style: Theme.of(context).textTheme.displayMedium,
                ),

                /*-----------------Welcome Header End -----------------*/

                /*-----------------Welcome Button Start -----------------*/

                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'PROFILE',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedOutState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhoneLoginScreen()));
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).logOut();
                        },
                        child: const Text(
                          'LOG OUT',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'LINK PHONE',
                    ),
                  ),
                ),

                /*-----------------Welcome Button End -----------------*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
