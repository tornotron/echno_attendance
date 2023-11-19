import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/user/hr_screens/add_employee.dart';
import 'package:echno_attendance/user/hr_screens/employee_register.dart';
import 'package:echno_attendance/user/hr_screens/update_details.dart';
import 'package:flutter/material.dart';

class HRDashboardScreen extends StatefulWidget {
  const HRDashboardScreen({Key? key}) : super(key: key);

  @override
  State<HRDashboardScreen> createState() => _HRDashboardScreenState();
}

class _HRDashboardScreenState extends State<HRDashboardScreen> {
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  late List<DashboardItem> gridData;

  @override
  void initState() {
    super.initState();
    gridData = [
      DashboardItem(
        icon: Icons.person_add_alt_1_rounded,
        text: 'Add Employee',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddNewEmployee();
          }));
        },
      ),
      DashboardItem(
        icon: Icons.checklist_rtl_rounded,
        text: 'Update Details',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const UpdateEmployeeDetails();
          }));
        },
      ),
      DashboardItem(
        icon: Icons.person_search_rounded,
        text: 'Employee Register',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const EmployeeRegisterScreen();
          }));
        },
      ),
      DashboardItem(
        icon: Icons.location_history_rounded,
        text: 'Attendance Report',
        onTap: () {},
      ),
      DashboardItem(
        icon: Icons.app_registration_rounded,
        text: 'Leave Register',
        onTap: () {},
      ),
      DashboardItem(
        icon: Icons.settings_rounded,
        text: 'Settings',
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode
            ? echnoLightBlueColor
            : echnoLogoColor, // Use your actual colors here
        title: const Text('HR Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: gridData.length,
          itemBuilder: (context, index) {
            return DashboardItemWidget(item: gridData[index]);
          },
        ),
      ),
    );
  }
}

class DashboardItem {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  DashboardItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

class DashboardItemWidget extends StatelessWidget {
  final DashboardItem item;

  const DashboardItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Card(
        color: Theme.of(context).brightness == Brightness.dark
            ? echnoLightBlueColor
            : echnoLogoColor, // Use your actual colors here
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 48.0,
                color: echnoDarkColor, // Customize the icon color if needed
              ),
              const SizedBox(height: 8.0),
              Text(
                item.text,
                style: const TextStyle(
                  fontFamily: 'TT Chocolates Bold',
                  fontSize: 15.0,
                  color: echnoDarkColor, // Customize the text color if needed
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
