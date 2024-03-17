import 'package:echno_attendance/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;
  final bool isDark;
  const ProfileMenuWidget(
      {required this.title,
      required this.icon,
      required this.isDark,
      required this.onPressed,
      this.endIcon = true,
      this.textColor,
      super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: textColor ??
                Theme.of(context).textTheme.titleSmall?.copyWith().color),
      ),
      leading: Icon(icon,
          color: isDark ? EchnoColors.secondary : EchnoColors.primary),
      trailing: endIcon
          ? Icon(
              Icons.arrow_forward_ios,
              color: isDark ? EchnoColors.secondary : EchnoColors.primary,
              size: 15.0,
            )
          : const SizedBox(
              width: 0,
              height: 0,
            ),
      onTap: onPressed,
    );
  }
}
