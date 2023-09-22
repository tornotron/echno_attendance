import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/text_style.dart';
import 'package:echno_attendance/user/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 300,
          centerTitle: true,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: echnoBlueColor),
          backgroundColor: echnoBlueColor,
          flexibleSpace: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 115,
                  width: 115,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/icons/Profile.png"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Employee Name",
                  style: EchnoTextTheme.darkTextTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Designation",
                  style: EchnoTextTheme.darkTextTheme.titleLarge,
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LoginButton(
                  buttonName: "Apply Leave",
                  buttonRadius: 19,
                  buttonWidth: 250,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
