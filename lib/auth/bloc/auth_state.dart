import 'package:echno_attendance/auth/services/index.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthLoggedInState extends AuthState {
  final AuthUser user;
  const AuthLoggedInState(this.user);
}

class AuthEmailNotVerifiedState extends AuthState {
  const AuthEmailNotVerifiedState();
}

class AuthLoggedOutState extends AuthState {
  final Exception? exception;
  const AuthLoggedOutState(this.exception);
}

class AuthErrorState extends AuthState {
  final Exception exception;
  const AuthErrorState(this.exception);
}
