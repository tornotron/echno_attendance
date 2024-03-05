import 'package:echno_attendance/auth/domain/firebase/auth_handler.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/auth/domain/firebase/firebase_auth_handler.dart';
// import 'package:echno_attendance/employee/models/employee.dart';

class AuthService implements AuthHandler {
  final AuthHandler _handler;
  const AuthService(this._handler);

  factory AuthService.firebase() {
    return AuthService(FirebaseAuthHandler());
  }

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    return _handler.createUser(email: email, password: password);
  }

  @override
  AuthUser? get currentUser {
    return _handler.currentUser;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    return _handler.logIn(email: email, password: password);
  }

  @override
  Future<void> logOut() {
    return _handler.logOut();
  }

  @override
  Future<void> sendEmailVerification() {
    return _handler.sendEmailVerification();
  }

  @override
  Future<void> resetPassword({required String toEmail}) {
    return _handler.resetPassword(toEmail: toEmail);
  }

  @override
  Future<void> initialize() {
    return _handler.initialize();
  }
}
