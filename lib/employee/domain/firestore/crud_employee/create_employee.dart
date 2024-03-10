import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';

abstract class ICreateEmployee {
  Future<Employee?> createEmployee({
    required String employeeId,
    required String employeeName,
    required String companyEmail,
    required String phoneNumber,
    required EmployeeRole employeeRole,
    required bool employeeStatus,
  });
}
