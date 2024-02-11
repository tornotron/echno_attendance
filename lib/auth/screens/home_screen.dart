import 'package:echno_attendance/attendance/services/location_service.dart';
import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/widgets/link_auth_user.dart';
import 'package:echno_attendance/leave_module/screens/leave_application.dart';
import 'package:echno_attendance/leave_module/screens/leave_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      final authBloc = context.read<AuthBloc>();
                      final shouldLogout = await showLogOutDialog(context);
                      if (shouldLogout) {
                        authBloc.add(const AuthLogOutEvent());
                      }
                    },
                    child: const Text(
                      'LOG OUT',
                    ),
                  ),
                ),

                /*-----------------Welcome Button End -----------------*/
                const SizedBox(height: 15),
                /*-----------------Toggle for Link & Unlink Auth Providers -----------------*/
                const LinkSwitchButton(),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentLocation =
                          await LocationService().getCurrentLocation();
                      // const targetLatitude = 23.8103;
                      // const targetLongitude = 30.810;
                      const targetLatitude = 10.065206;
                      const targetLongitude = 76.629128;

                      final bool isWithinSite =
                          await LocationService().isEmployeeWithinSite(
                        siteLattitude: targetLatitude,
                        siteLongitude: targetLongitude,
                        currentLattitude: currentLocation.latitude,
                        currentLongitude: currentLocation.longitude,
                      );
                      if (isWithinSite) {
                        devtools.log('You are in the range');
                      } else {
                        devtools.log('You are not in the range');
                      }
                    },
                    child: const Text(
                      'Get Location',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
