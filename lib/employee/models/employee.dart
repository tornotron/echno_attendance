import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/employee/services/crud/read_employee.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';

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

  final DatabaseHandler firestoreUserImplementation =
      FirestoreDatabaseHandler();

  Future<void> fetchAndUpdateEmployeeDetails() async {
    Map<String, dynamic> employeeDetails =
        await user.searchEmployeeByUID(uid: user.uid);
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
    return firestoreUserImplementation.readEmployee(employeeId: employeeId);
  }

  factory Employee.fromFirebaseUser(AuthUser authUser) {
    return Employee(
      user: authUser,
    );
  }
}
