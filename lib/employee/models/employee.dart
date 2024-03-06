import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';

class Employee {
  Employee({
    required this.authUser,
    required this.employeeID,
    required this.employeeName,
    required this.employeeStatus,
    required this.employeeRole,
  });

  final AuthUser authUser;
  final String employeeID;
  final String employeeName;
  final bool employeeStatus;
  final EmployeeRole employeeRole;

  get uid => authUser.uid;
  get email => authUser.email;
  get isEmailVerified => authUser.isEmailVerified;

  Employee._({
    required this.authUser,
    required this.employeeID,
    required this.employeeName,
    required this.employeeStatus,
    required this.employeeRole,
  });

  static final EmployeeService employeeService = EmployeeService.firestore();

  static Future<Employee> fromFirebaseUser(AuthUser authUser) async {
    Map<String, dynamic> employeeDetails = await employeeService
        .searchEmployeeByAuthUserId(authUserId: authUser.uid);
    final employeeID = employeeDetails['employee-id'];
    final employeeName = employeeDetails['full-name'];
    final employeeStatus = employeeDetails['employee-status'];
    final employeeRole = employeeDetails['employee-role'];
    return Employee._(
        authUser: authUser,
        employeeID: employeeID,
        employeeName: employeeName,
        employeeStatus: employeeStatus,
        employeeRole: employeeRole);
  }
}
