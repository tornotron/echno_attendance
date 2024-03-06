import 'package:echno_attendance/employee/domain/firestore/crud_employee/read_employee.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';

///
/// `Employee` is a class that implements `IReadEmployeeService` interface.
///
/// It represents an employee with properties such as `uid`, `email`, `isEmailVerified`,
/// `employeeID`, `employeeName`, `employeeStatus`, and `employeeRole`.
///
/// An instance of `Employee` is created either by passing an `AuthUser` object to the constructor
/// or by using the factory constructor `fromFirebaseUser`.
///
/// It uses an instance of `EmployeeService` to interact with the Firestore database.
///
/// It provides methods to fetch and update employee details (`fetchAndUpdateEmployeeDetails`)
/// and to read employee details (`readEmployee`).
///
class Employee implements IReadEmployeeService {
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

  final EmployeeService employeeService = EmployeeService.firestore();

  Future<void> fetchAndUpdateEmployeeDetails() async {
    Map<String, dynamic> employeeDetails =
        await employeeService.searchEmployeeByUid(uid: user.uid);
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
    return employeeService.readEmployee(employeeId: employeeId);
  }

  factory Employee.fromFirebaseUser(AuthUser authUser) {
    return Employee(
      user: authUser,
    );
  }
}
