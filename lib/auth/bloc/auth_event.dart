import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthInitializeEvent extends AuthEvent {
  const AuthInitializeEvent();
}

class AuthNeedToRegisterEvent extends AuthEvent {
  const AuthNeedToRegisterEvent();
}

class AuthRegistrationEvent extends AuthEvent {
  final String email;
  final String password;
  const AuthRegistrationEvent({
    required this.email,
    required this.password,
  });
}

class AuthVerifyEmailEvent extends AuthEvent {
  const AuthVerifyEmailEvent();
}

class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;
  const AuthLogInEvent({
    required this.email,
    required this.password,
  });
}

class AuthLogOutEvent extends AuthEvent {
  const AuthLogOutEvent();
}
