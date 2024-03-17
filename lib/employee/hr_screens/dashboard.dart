import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/employee/hr_screens/add_employee.dart';
import 'package:echno_attendance/employee/hr_screens/employee_register.dart';
import 'package:echno_attendance/employee/hr_screens/update_details.dart';
import 'package:echno_attendance/leave_module/screens/leave_register.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:echno_attendance/employee/hr_screens/attendance_report/employee_attendancereport.dart';

class HRDashboardScreen extends StatefulWidget {
  const HRDashboardScreen({super.key});

  @override
  State<HRDashboardScreen> createState() => _HRDashboardScreenState();
}

class _HRDashboardScreenState extends State<HRDashboardScreen> {
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AttendanceReportScreen();
          }));
        },
      ),
      DashboardItem(
        icon: Icons.app_registration_rounded,
        text: 'Leave Register',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LeaveRegisterScreen();
          }));
        },
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
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EchnoAppBar(
        leadingIcon: Icons.arrow_back_ios_new,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: Text(
          'HR Dashboard',
          style: Theme.of(context).textTheme.headlineSmall?.apply(
                color: isDark ? EchnoColors.black : EchnoColors.white,
              ),
        ),
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

  const DashboardItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: item.onTap,
      child: Card(
        color: isDark ? EchnoColors.secondary : EchnoColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 48.0,
                color: isDark ? EchnoColors.black : EchnoColors.white,
              ),
              const SizedBox(height: 8.0),
              Text(
                item.text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: isDark ? EchnoColors.black : EchnoColors.white,
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
