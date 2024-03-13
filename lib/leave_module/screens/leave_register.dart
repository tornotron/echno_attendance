import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/leave_module/widgets/register_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaveRegisterScreen extends StatefulWidget {
  const LeaveRegisterScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveRegisterScreen> createState() => LeaveRegisterScreenState();
}

class LeaveRegisterScreenState extends State<LeaveRegisterScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final TextEditingController _searchController = TextEditingController();
  late final Employee currentEmployee;

  Future<void> _fetchCurrentEmployee() async {
    final employee = await EmployeeService.firestore().currentEmployee;
    setState(() {
      currentEmployee = employee;
    });
  }

  @override
  void initState() {
    _fetchCurrentEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text(leaveRegisterAppBarTitle),
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
            padding: LeaveRegisterScreen.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  leaveRegisterScreenTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  leaveRegisterSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: leaveRegisterFilterFieldLabel,
                    hintText: leaveRegisterFilterFieldHint,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    // Trigger filtering when the user types
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 3.0),
              ],
            ),
          ),
          leaveRegisterStreamBuilder(
            isDarkMode: isDarkMode,
            searchController: _searchController,
            context: context,
          ),
        ],
      ),
    );
    if (currentEmployee.employeeRole != EmployeeRole.hr) {
      content = Scaffold(
        body: Center(
          child: Text(
            'You are not authorized to access this Page. Please contact HR',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }
    return content;
  }
}
