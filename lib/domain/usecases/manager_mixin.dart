import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

mixin ManagerMixin {
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
        log("employee doesn't exist");
      }
    } on FirebaseException catch (error) {
      log('Firebase Exception: ${error.message}');
    } catch (e) {
      log('Other Exception: $e');
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
