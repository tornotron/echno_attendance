import 'package:echno_attendance/employee/services/crud_employee/read_employee.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';

class Employee implements IReadEmployee {
  Employee({
    required this.user,
  });

  final AuthUser user;
  late final String? uid;
  late final String? email;
  late final bool? isemailVerified;
  late final String? employeeID;
  late final String? employeeName;
  late final bool? employeeStatus;
  late final String? employeeRole;

  final EmployeeService databaseService = EmployeeService.firestore();

  Future<void> fetchAndUpdateEmployeeDetails() async {
    Map<String, dynamic> employeeDetails =
        await databaseService.searchEmployeeByUid(uid: user.uid);
    uid = user.uid;
    email = user.email;
    isemailVerified = user.isemailVerified;
    employeeID = employeeDetails['employee-id'];
    employeeName = employeeDetails['full-name'];
    employeeStatus = employeeDetails['employee-status'];
    employeeRole = employeeDetails['employee-role'];
  }

  @override
  Future<Map<String, dynamic>> readEmployee({required String employeeId}) {
    return databaseService.readEmployee(employeeId: employeeId);
  }

  factory Employee.fromFirebaseUser(AuthUser authUser) {
    return Employee(
      user: authUser,
    );
  }
}
