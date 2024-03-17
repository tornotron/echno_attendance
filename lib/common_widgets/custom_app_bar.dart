import 'package:echno_attendance/utilities/helpers/device_helper.dart';
import 'package:flutter/material.dart';

class EchnoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  const EchnoAppBar({
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leadingIcon != null
          ? IconButton(
              icon: Icon(leadingIcon),
              onPressed: leadingOnPressed,
            )
          : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(DeviceUtilityHelpers.getAppBarHeight());
}
