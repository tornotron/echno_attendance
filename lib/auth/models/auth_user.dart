import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String uid;
  final String email;
  final bool isEmailVerified;
  final bool isHr;

  const AuthUser(
    this.isHr, {
    required this.uid,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      false,
      uid: user.uid,
      email: user.email!,
      isEmailVerified: user.emailVerified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'isHr': isHr,
    };
  }
}
