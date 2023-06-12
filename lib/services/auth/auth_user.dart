import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isemailVerified;

  const AuthUser({required this.isemailVerified});

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(isemailVerified: user.emailVerified);
  }
}
