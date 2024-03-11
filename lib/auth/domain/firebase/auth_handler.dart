import 'package:echno_attendance/auth/models/auth_user.dart';
// import 'package:echno_attendance/employee/models/employee.dart';

abstract class AuthHandler {
  AuthUser? get currentUser;

  Future<void> initialize();

  Future<AuthUser> logIn({
    required String authUserEmail,
    required String password,
  });
  Future<AuthUser> createUser({
    required String authUserEmail,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> resetPassword({required String authUserEmail});
}
