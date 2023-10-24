import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:echno_attendance/domain/usecases/manager_abstract.dart';
import 'package:echno_attendance/domain/usecases/userhandling_implementation.dart';

class HrClass implements Amanager {
  final Amanager firestoreUserImplementation = FirestoreUserImplementation();

  @override
  Future createUser(
      {required String userId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) {
    return firestoreUserImplementation.createUser(
        userId: userId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future updateUser(
      {required String? userId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) {
    return firestoreUserImplementation.updateUser(userId: userId);
  }

  @override
  Future deleteUser({required String userId}) {
    return firestoreUserImplementation.updateUser(userId: userId);
  }

  @override
  Future<Map<String, dynamic>> readUser({required String userId}) {
    return firestoreUserImplementation.readUser(userId: userId);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HrClass().createUser(
      userId: '5000',
      name: 'justin',
      email: 'justin@gmail.com',
      phoneNumber: '98875764',
      userRole: 'manager',
      isActiveUser: true);
}
