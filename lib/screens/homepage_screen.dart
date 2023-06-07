import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

enum MenuActions { logout }

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echno"),
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (value) {
              devtools.log('Logged out!');
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
