import 'package:flutter/material.dart';

class ProfileFieldsWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ProfileFieldsWidget({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
