import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/domain/usecases/pm_manager_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HrClass {
  // final FirebaseFirestore firestore;
  // HrClass({required this.firestore});
  Future createUser(
      {required String userId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'employee-id': userId,
        'full-name': name,
        'email-id': email,
        'phone': phoneNumber,
        'employee-role': userRole,
        'employee-status': isActiveUser,
      });
    } on FirebaseException catch (error) {
      print('Firebase Exception: ${error.message}');
    } catch (e) {
      print('Other Exception: $e');
    }
  }

  Future updateUser(
      {required String? userId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(userId);

      final updateData = <String, dynamic>{};

      if (name != null) {
        updateData['full-name'] = name;
      }

      if (email != null) {
        updateData['email-id'] = email;
      }

      if (phoneNumber != null) {
        updateData['phone'] = phoneNumber;
      }

      if (userRole != null) {
        updateData['employee-role'] = userRole;
      }

      if (isActiveUser != null) {
        updateData['employee-status'] = isActiveUser;
      }

      await docRef.update(updateData);
    } on FirebaseException catch (error) {
      print('Firebase Exception: ${error.message}');
    } catch (e) {
      print('Other Exception: $e');
    }
  }

  Future deleteUser({required String userId}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } on FirebaseException catch (error) {
      print('Firebase Exception: ${error.message}');
    } catch (e) {
      print('Other Exception: $e');
    }
  }

  Future<Map<String, dynamic>> readUser({
    required String userId,
  }) async {
    String? name, email, phoneNumber, userRole;
    bool? isActiveUser;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(userId).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;
        name = employeeData['full-name'];
        email = employeeData['email-id'];
        phoneNumber = employeeData['phone'];
        userRole = employeeData['employee-role'];
        isActiveUser = employeeData['employee-status'];
      } else {
        print("employee doesn't exist");
      }
    } on FirebaseException catch (error) {
      print('Firebase Exception: ${error.message}');
    } catch (e) {
      print('Other Exception: $e');
    }
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
      'isActiveUser': isActiveUser,
    };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<String, dynamic> myMap = await PmClass().readUser(userId: '1000');
  myMap.forEach((key, value) {
    print('$key: $value');
  });
}
