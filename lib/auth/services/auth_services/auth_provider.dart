import 'package:echno_attendance/auth/services/auth_services/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

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

  Future<Map<String, dynamic>> searchForEmployeeInFirestore(
      {required String employeeID});

  Future<void> updateUserUIDToFirestore(
      {required String employeeID, required String? uid});
}
