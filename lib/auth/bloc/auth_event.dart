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
  final String authUserEmail;
  final String password;
  final String? emplyeeId;
  const AuthRegistrationEvent(
    this.emplyeeId, {
    required this.authUserEmail,
    required this.password,
  });
}

class AuthVerifyEmailEvent extends AuthEvent {
  const AuthVerifyEmailEvent();
}

class AuthLogInEvent extends AuthEvent {
  final String authUserEmail;
  final String password;
  const AuthLogInEvent({
    required this.authUserEmail,
    required this.password,
  });
}

class AuthForgotPasswordEvent extends AuthEvent {
  final String? authUserEmail;
  const AuthForgotPasswordEvent({
    this.authUserEmail,
  });
}

class AuthLogOutEvent extends AuthEvent {
  const AuthLogOutEvent();
}

class AuthPhoneLogInInitiatedEvent extends AuthEvent {
  const AuthPhoneLogInInitiatedEvent();
}
