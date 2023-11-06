import 'package:echno_attendance/domain/usecases/manager_abstract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class FirestoreUserServices implements FirestoreUserHandleProvider {
  final logs = logger(FirestoreUserServices, Level.info);
  @override
  Future createUser(
      {required String userId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot useridCheck = await userCollection.doc(userId).get();

      if (!useridCheck.exists) {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'employee-id': userId,
          'full-name': name,
          'email-id': email,
          'phone': phoneNumber,
          'employee-role': userRole,
          'employee-status': isActiveUser,
        });
      } else {
        logs.i('user already exits');
      }
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
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
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
  Future deleteUser({required String userId}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }

  @override
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
        logs.i("employee doesn't exist");
      }
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
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
