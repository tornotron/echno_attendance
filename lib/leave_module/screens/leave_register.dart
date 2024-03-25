import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/leave_module/widgets/register_stream_builder.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';

class LeaveRegisterScreen extends StatefulWidget {
  const LeaveRegisterScreen({super.key});

  @override
  State<LeaveRegisterScreen> createState() => LeaveRegisterScreenState();
}

class LeaveRegisterScreenState extends State<LeaveRegisterScreen> {
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
    final isDark = EchnoHelperFunctions.isDarkMode(context);

    Widget content = Column(
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
        const SizedBox(height: EchnoSize.spaceBtwSections),
        TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(EchnoSize.borderRadiusLg),
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
        const SizedBox(height: EchnoSize.spaceBtwItems),
        const Divider(height: EchnoSize.dividerHeight),
        leaveRegisterStreamBuilder(
          isDarkMode: isDark,
          searchController: _searchController,
          context: context,
        ),
      ],
    );
    if (currentEmployee.employeeRole != EmployeeRole.hr) {
      content = Center(
        child: Text(
          'You are not authorized to access this Page. Please contact HR',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Scaffold(
      appBar: EchnoAppBar(
        leadingIcon: Icons.arrow_back_ios_new,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: Text(
          'Leave Register',
          style: Theme.of(context).textTheme.headlineSmall?.apply(
                color: isDark ? EchnoColors.black : EchnoColors.white,
              ),
        ),
      ),
      body: Padding(
        padding: CustomPaddingStyle.defaultPaddingWithAppbar,
        child: content,
      ),
    );
  }
}
