import 'package:echno_attendance/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LinkSwitchButton extends StatefulWidget {
  const LinkSwitchButton({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LinkSwitchButton> createState() => _LinkSwitchButtonState();
}

class _LinkSwitchButtonState extends State<LinkSwitchButton> {
  bool _googleSelected = false;
  bool _phoneSelected = false;
  bool _appleSelected = false;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.phone_android_outlined),
            title: const Text('Link Phone'),
            trailing: Switch(
              value: _phoneSelected,
              onChanged: (bool value) {
                setState(() {
                  _phoneSelected = value;
                });
              },
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              googleIcon,
              width: 20,
              height: 20,
            ),
            title: const Text('Link Google'),
            trailing: Switch(
              value: _googleSelected,
              onChanged: (bool value) {
                setState(() {
                  _googleSelected = value;
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.apple_outlined),
            title: const Text('Link Apple'),
            trailing: Switch(
              value: _appleSelected,
              onChanged: (bool value) {
                setState(() {
                  _appleSelected = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
