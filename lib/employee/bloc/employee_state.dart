import 'package:echno_attendance/employee/models/employee.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class EmployeeState {
  final Employee? currentEmployee;
  const EmployeeState({
    this.currentEmployee,
  });
}

class EmployeeNotInitializedState extends EmployeeState {
  const EmployeeNotInitializedState({super.currentEmployee});
}

class EmployeeInitializedState extends EmployeeState {
  const EmployeeInitializedState({required Employee currentEmployee})
      : super(currentEmployee: currentEmployee);
}

class EmployeeHomeState extends EmployeeState {
  const EmployeeHomeState({required Employee currentEmployee})
      : super(currentEmployee: currentEmployee);
}

class EmployeeProfileState extends EmployeeState {
  const EmployeeProfileState({required Employee currentEmployee})
      : super(currentEmployee: currentEmployee);
}
