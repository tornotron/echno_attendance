import 'package:echno_attendance/auth/services/index.dart';
import 'package:echno_attendance/auth/widgets/link_auth_user.dart';
import 'package:echno_attendance/utilities/index.dart';
import 'package:flutter/material.dart';

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
                      final shouldLogout = await showLogOutDialog(context);
                      if (shouldLogout) {
                        await AuthService.firebase().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (_) => false,
                        );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
