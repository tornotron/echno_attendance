import 'package:echno_attendance/auth/services/auth_services/auth_provider.dart';
import 'package:echno_attendance/auth/services/auth_services/auth_user.dart';
import 'package:echno_attendance/auth/services/auth_services/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider _provider;
  const AuthService(this._provider);

  factory AuthService.firebase() {
    return AuthService(FirebaseAuthProvider());
  }

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    return _provider.createUser(email: email, password: password);
  }

  @override
  AuthUser? get currentUser {
    return _provider.currentUser;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    return _provider.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() {
    return _provider.logOut();
  }

  @override
  Future<void> sendEmailVerification() {
    return _provider.sendEmailVerification();
  }

  @override
  Future<void> resetPassword({required String toEmail}) {
    return _provider.resetPassword(toEmail: toEmail);
  }

  @override
  Future<void> initialize() {
    return _provider.initialize();
  }

  @override
  Future<Map<String, dynamic>> searchForEmployeeInFirestore(
      {required String employeeID}) {
    return _provider.searchForEmployeeInFirestore(employeeID: employeeID);
  }

  @override
  Future<void> updateUserUIDToFirestore({
    required String employeeID,
    required String? uid,
  }) {
    return _provider.updateUserUIDToFirestore(
      employeeID: employeeID,
      uid: uid,
    );
  }
}
