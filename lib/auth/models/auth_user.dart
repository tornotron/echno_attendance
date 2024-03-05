import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';
import 'dart:developer' as devtools show log;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<Map<String, dynamic>> searchEmployeeByUID(
      {required String uid}) async {
    try {
      // Search user with reference to the uid in firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> user =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        devtools.log('User found');
        return user;
      } else {
        devtools.log('User not found');
        return {}; // Return an empty map if no user is found
      }
    } catch (e) {
      devtools.log('Error searching for user: $e');
      return {}; // Return an empty map if an error occurs
    }
  }

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      false,
      uid: user.uid,
      email: user.email!,
      isemailVerified: user.emailVerified,
    );
  }
}
