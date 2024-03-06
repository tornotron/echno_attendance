import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/hr_employee_service.dart';

class HrEmployee extends Employee {
  HrEmployee({required super.user});

  final HrEmployeeService hrEmployeeService = HrEmployeeService.firestore();
}
