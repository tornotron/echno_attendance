import 'package:echno_attendance/user/enums/menu_action.dart';
import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echno"),
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (value) async {
              switch (value) {
                case MenuActions.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/',
                        (_) => false,
                      );
                      devtools.log('Logged out!');
                    }
                  }
                  break;
                default:
                  throw Exception("Unknown menu action: $value");
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuActions.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Welcome to Echno!"),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Log out?"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Log out"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
