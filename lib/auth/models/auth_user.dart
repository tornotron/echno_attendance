import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String authUserId;
  final String authUserEmail;
  final bool isEmailVerified;
  final bool isHr;

  const AuthUser(
    this.isHr, {
    required this.authUserId,
    required this.authUserEmail,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      false,
      authUserId: user.uid,
      authUserEmail: user.email!,
      isEmailVerified: user.emailVerified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth-user-id': authUserId,
      'auth-user-email': authUserEmail,
      'is-email-verified': isEmailVerified,
      'is-hr': isHr,
    };
  }
}
