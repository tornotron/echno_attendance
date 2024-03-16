import 'package:echno_attendance/employee/bloc/employee_bloc.dart';
import 'package:echno_attendance/employee/bloc/employee_event.dart';
import 'package:echno_attendance/employee/bloc/employee_state.dart';
import 'package:echno_attendance/employee/screens/homepage_screen.dart';
import 'package:echno_attendance/employee/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeStateManagementWidget extends StatefulWidget {
  const EmployeeStateManagementWidget({super.key});

  @override
  State<EmployeeStateManagementWidget> createState() =>
      _EmployeeStateManagementWidgetState();
}

class _EmployeeStateManagementWidgetState
    extends State<EmployeeStateManagementWidget> {
  @override
  Widget build(BuildContext context) {
    context.read<EmployeeBloc>().add(const EmployeeInitializeEvent());
    return BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is EmployeeInitializedState) {
            return const HomePage();
          } else if (state is EmployeeProfileState) {
            return const ProfileScreen();
          } else if (state is EmployeeHomeState) {
            return const HomePage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
