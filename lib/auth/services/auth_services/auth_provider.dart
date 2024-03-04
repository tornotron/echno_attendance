import 'package:echno_attendance/auth/services/auth_services/auth_user.dart';
// import 'package:echno_attendance/employee/models/employee.dart';

abstract class EchnoAuthProvider {
  AuthUser? get currentUser;
  // Future<Employee?> get currentEmployee;

  Future<void> initialize();

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> resetPassword({required String toEmail});
}
