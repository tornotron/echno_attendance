import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class HRDashboardScreen extends StatefulWidget {
  const HRDashboardScreen({Key? key}) : super(key: key);

  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<HRDashboardScreen> createState() => _HRDashboardScreenState();
}

class _HRDashboardScreenState extends State<HRDashboardScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  final List<Map<String, dynamic>> gridData = [
    {
      'icon': Icons.person_add_alt_1_rounded,
      'text': 'Add Employee',
      'onTap': () {},
    },
    {
      'icon': Icons.checklist_rtl_rounded,
      'text': 'Update Details',
      'onTap': () {},
    },
    {
      'icon': Icons.person_search_rounded,
      'text': 'Employee List',
      'onTap': () {},
    },
    {
      'icon': Icons.location_history_rounded,
      'text': 'Attendance Report',
      'onTap': () {},
    },
    {
      'icon': Icons.app_registration_rounded,
      'text': 'Leave Register',
      'onTap': () {},
    },
    {
      'icon': Icons.settings_rounded,
      'text': 'Settings',
      'onTap': () {},
    },
  ];

  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
          title: const Text('HR Dashboard'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          padding: HRDashboardScreen.containerPadding,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: gridData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: gridData[index]['onTap'],
                child: Card(
                  color: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          gridData[index]['icon'],
                          size: 48.0,
                          // Customize the icon color if needed
                          color: echnoDarkColor,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          gridData[index]['text'],
                          // Customize the text style if needed
                          style: const TextStyle(
                              fontFamily: 'TT Chocolates Bold',
                              fontSize: 15.0,
                              color: echnoDarkColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
