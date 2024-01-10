import 'auth_services/auth_user.dart';

class Employee {
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

  factory Employee.fromFirebaseUser(AuthUser authUser) {
    return Employee(
      user: authUser,
    );
  }
}
