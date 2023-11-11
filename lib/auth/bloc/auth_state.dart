import 'package:echno_attendance/auth/services/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthNotInitializedState extends AuthState {
  const AuthNotInitializedState();
}

class AuthRegistrationState extends AuthState {
  final Exception? exception;
  const AuthRegistrationState(this.exception);
}

class AuthLoggedInState extends AuthState {
  final AuthUser user;
  const AuthLoggedInState(this.user);
}

class AuthEmailNotVerifiedState extends AuthState {
  const AuthEmailNotVerifiedState();
}

class AuthForgotPasswordState extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;
  const AuthForgotPasswordState({
    required this.exception,
    required this.hasSentEmail,
  });
}

class AuthLoggedOutState extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthLoggedOutState({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
