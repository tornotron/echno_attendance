import 'package:echno_attendance/auth/bloc/auth_bloc.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/image_string.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/employee/widgets/profile_field_widget.dart';
import 'package:echno_attendance/employee/widgets/profile_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Employee currentEmployee;

  updateProfilePhoto() async {
    final imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxHeight: 512.0,
        maxWidth: 512.0);
    if (image != null) {
      final employeeService = EmployeeService.firestore();
      await employeeService.uploadImage(
          imagePath: 'Profile/',
          employeeId: currentEmployee.employeeId,
          image: image);
      _fetchCurrentEmployee();
    }
  }

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

  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
                  isDarkMode ? echnoLightBlueColor : echnoBlueColor),
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
          title: const Text('Profile'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
                          child: Image(
                              image: NetworkImage(currentEmployee.photoUrl!),
                              fit: BoxFit.cover),
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
                              color: echnoBlueColor,
                              borderRadius: BorderRadius.circular(100.00),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            updateProfilePhoto();
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
                  icon: Icons.settings,
                  title: 'Settings',
                  onPressed: () {},
                ),
                ProfileMenuWidget(
                  icon: Icons.leak_add_outlined,
                  title: 'Leaves',
                  onPressed: () {},
                ),
                Visibility(
                  visible: currentEmployee.employeeRole == EmployeeRole.hr,
                  child: ProfileMenuWidget(
                    icon: Icons.dashboard_outlined,
                    title: 'HR Dashboard',
                    onPressed: () {},
                  ),
                ),
                ProfileMenuWidget(
                    title: 'Log Out',
                    textColor: errorRedColor,
                    icon: Icons.logout_rounded,
                    onPressed: () async {
                      final authBloc = context.read<AuthBloc>();
                      final shouldLogout = await showLogOutDialog(context);
                      if (shouldLogout) {
                        authBloc.add(const AuthLogOutEvent());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
