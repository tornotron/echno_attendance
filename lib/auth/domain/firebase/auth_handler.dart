import 'package:echno_attendance/auth/models/auth_user.dart';
// import 'package:echno_attendance/employee/models/employee.dart';

abstract class AuthHandler {
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