import 'package:echno_attendance/services/auth/auth_provider.dart';
import 'package:echno_attendance/services/auth/auth_user.dart';
import 'package:echno_attendance/services/auth/firebase_auth_provider.dart';

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
}
