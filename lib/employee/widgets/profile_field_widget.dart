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
            style: const TextStyle(
                fontFamily: 'TT Chocolates',
                fontSize: 17.0,
                fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            value,
            style: const TextStyle(
                fontFamily: 'TT Chocolates',
                fontSize: 17.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
