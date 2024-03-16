import 'package:echno_attendance/employee/models/employee.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class EmployeeEvent {
  const EmployeeEvent();
}

class EmployeeInitializeEvent extends EmployeeEvent {
  const EmployeeInitializeEvent();
}

class EmployeeHomeEvent extends EmployeeEvent {
  final Employee currentEmployee;

  const EmployeeHomeEvent({
    required this.currentEmployee,
  });
}

class EmployeeProfileEvent extends EmployeeEvent {
  final Employee currentEmployee;
  const EmployeeProfileEvent({
    required this.currentEmployee,
  });
}
