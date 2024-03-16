import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';

class Employee {
  Employee({
    this.authUser,
    this.photoUrl,
    required this.employeeId,
    required this.employeeName,
    required this.companyEmail,
    required this.phoneNumber,
    required this.employeeStatus,
    required this.employeeRole,
  });
  final AuthUser? authUser;
  final String? photoUrl;
  final String employeeId;
  final String employeeName;
  final String companyEmail;
  final String phoneNumber;
  final bool employeeStatus;
  final EmployeeRole employeeRole;

  dynamic authUserProperty(String property) {
    if (authUser == null) {
      throw Exception(
          'This employee instance has no authenticated user associated with it.');
    }
    return authUser?.toJson()[property];
  }

  String get authUserId => authUserProperty('auth-user-id');
  String get authUserEmail => authUserProperty('auth-user-email');
  String get isEmailVerified => authUserProperty('is-email-verified');

  String get employeeRoleString => employeeRole.toString().split('.').last;

  Employee._({
    required this.authUser,
    required this.photoUrl,
    required this.employeeId,
    required this.employeeName,
    required this.companyEmail,
    required this.phoneNumber,
    required this.employeeStatus,
    required this.employeeRole,
  });

  static final EmployeeService employeeService = EmployeeService.firestore();

  static Future<Employee> fromFirebaseUser(AuthUser authUser) async {
    Map<String, dynamic> employeeDetails = await employeeService
        .searchEmployeeByAuthUserId(authUserId: authUser.authUserId);
    final employeePhotoUrl = employeeDetails['photo-url'];
    final employeeId = employeeDetails['employee-id'];
    final employeeName = employeeDetails['employee-name'];
    final companyEmail = employeeDetails['company-email'];
    final phoneNumber = employeeDetails['phone-number'];
    final employeeStatus = employeeDetails['employee-status'];
    final employeeRole = getEmployeeRole(employeeDetails['employee-role']);
    return Employee._(
        authUser: authUser,
        photoUrl: employeePhotoUrl,
        employeeId: employeeId,
        employeeName: employeeName,
        companyEmail: companyEmail,
        phoneNumber: phoneNumber,
        employeeStatus: employeeStatus,
        employeeRole: employeeRole);
  }

  // This method is used to create an empty employee instance
  factory Employee.isEmpty() {
    return Employee(
      photoUrl: '',
      employeeId: '',
      employeeName: '',
      companyEmail: '',
      phoneNumber: '',
      employeeStatus: false,
      employeeRole: EmployeeRole.emp,
    );
  }
}
