import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';

abstract class IUpdateEmployee {
  Future<Employee?> updateEmployee({
    required String? employeeId,
    String? employeeName,
    String? companyEmail,
    String? phoneNumber,
    EmployeeRole? employeeRole,
    bool? employeeStatus,
  });
}
