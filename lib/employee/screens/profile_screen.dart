import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/employee/bloc/employee_bloc.dart';
import 'package:echno_attendance/employee/bloc/employee_event.dart';
import 'package:echno_attendance/employee/bloc/employee_state.dart';
import 'package:echno_attendance/employee/hr_screens/dashboard.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/employee/widgets/profile_field_widget.dart';
import 'package:echno_attendance/employee/widgets/profile_menu_widget.dart';
import 'package:echno_attendance/leave_module/screens/leave_status_screen.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Employee currentEmployee;

  @override
  void initState() {
    currentEmployee = context.read<EmployeeBloc>().state.currentEmployee ??
        Employee.isEmpty();
    Employee.isEmpty();
    super.initState();
  }

  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {},
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: EchnoAppBar(
            leadingIcon: Icons.arrow_back_ios_new,
            leadingOnPressed: () {
              context
                  .read<EmployeeBloc>()
                  .add(EmployeeHomeEvent(currentEmployee: currentEmployee));
            },
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.headlineSmall?.apply(
                    color: isDark ? EchnoColors.black : EchnoColors.white,
                  ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: ProfileScreen.containerPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Visibility(
                          visible: currentEmployee.photoUrl == null,
                          child: SizedBox(
                            height: 120.0,
                            width: 120.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.00),
                              child: const Image(
                                image: AssetImage(profilePlaceholder),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120.0,
                          width: 120.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.00),
                            child: currentEmployee.photoUrl != null
                                ? Image.network(currentEmployee.photoUrl!,
                                    fit: BoxFit.cover)
                                : const Image(
                                    image: AssetImage(profilePlaceholder),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            child: Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? EchnoColors.secondary
                                    : EchnoColors.primary,
                                borderRadius: BorderRadius.circular(100.00),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: isDark
                                    ? EchnoColors.black
                                    : EchnoColors.white,
                              ),
                            ),
                            onTap: () async {
                              context.read<EmployeeBloc>().add(
                                    EmployeeUpdatePhotoEvent(
                                      employeeId: currentEmployee.employeeId,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileFieldsWidget(
                      title: 'Employee Name',
                      value: currentEmployee.employeeName,
                      icon: Icons.person_outlined),
                  const Divider(),
                  ProfileFieldsWidget(
                      title: 'Employee ID',
                      value: currentEmployee.employeeId,
                      icon: Icons.tag),
                  const Divider(),
                  ProfileFieldsWidget(
                      title: 'Email',
                      value: currentEmployee.companyEmail,
                      icon: Icons.email_outlined),
                  const Divider(),
                  ProfileFieldsWidget(
                      title: 'Phone',
                      value: currentEmployee.phoneNumber,
                      icon: Icons.phone_outlined),
                  const Divider(),
                  ProfileFieldsWidget(
                      title: 'Designation',
                      value: getEmloyeeRoleName(currentEmployee.employeeRole),
                      icon: Icons.work_outline),
                  const Divider(),
                  ProfileMenuWidget(
                      isDark: isDark,
                      icon: Icons.settings,
                      title: 'Settings',
                      onPressed: () {}),
                  ProfileMenuWidget(
                    isDark: isDark,
                    icon: Icons.leak_add_outlined,
                    title: 'Leaves',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LeaveStatusScreen();
                      }));
                    },
                  ),
                  ProfileMenuWidget(
                      isDark: isDark,
                      icon: Icons.task_outlined,
                      title: 'Tasks',
                      onPressed: () {}),
                  Visibility(
                    visible: currentEmployee.employeeRole == EmployeeRole.hr,
                    child: ProfileMenuWidget(
                      isDark: isDark,
                      icon: Icons.dashboard_outlined,
                      title: 'HR Dashboard',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HRDashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  ProfileMenuWidget(
                      isDark: isDark,
                      title: 'Log Out',
                      textColor: errorRedColor,
                      icon: Icons.logout_rounded,
                      onPressed: () async {
                        final authBloc = context.read<AuthBloc>();
                        final shouldLogout = await showLogOutDialog(context);
                        if (shouldLogout) {
                          authBloc.add(const AuthLogOutEvent());
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
