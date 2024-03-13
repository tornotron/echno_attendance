import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/widgets/status_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveStatusScreen> createState() => LeaveStatusScreenState();
}

class LeaveStatusScreenState extends State<LeaveStatusScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text(leaveStatusAppBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: LeaveStatusScreen.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  leaveStatusScreenTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  leaveStatusSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 3.0),
              ],
            ),
          ),
          const LeaveStatusStreamWidget(),
        ],
      ),
    );
  }
}
