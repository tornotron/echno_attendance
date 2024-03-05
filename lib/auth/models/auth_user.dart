import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String uid;
  final String email;
  final bool isemailVerified;
  final bool isHr;

  const AuthUser(
    this.isHr, {
    required this.uid,
    required this.email,
    required this.isemailVerified,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      false,
      uid: user.uid,
      email: user.email!,
      isemailVerified: user.emailVerified,
    );
  }
}
