import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/auth/services/auth_db_services/auth_database_provider.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';

class FirestoreAuthProvider implements AuthDatabaseProvider {
  @override
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeID}) async {
    String? name, email, phoneNumber, userRole;
    bool? isActiveUser;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeID).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;
        name = employeeData['full-name'];
        email = employeeData['email-id'];
        phoneNumber = employeeData['phone'];
        userRole = employeeData['employee-role'];
        isActiveUser = employeeData['employee-status'];
      }
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'not-found':
          throw NotAnEmployeeException();
        default:
          throw GenericAuthException('Firestore Exception: ${error.message}');
      }
    } catch (e) {
      throw GenericAuthException('Other Exception: $e');
    }
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
      'isActiveUser': isActiveUser,
    };
  }

  @override
  Future<void> updateUserUIDToDatabase({
    required String employeeID,
    required String? uid,
  }) async {
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeID).get();

      if (employeeDocument.exists) {
        await employeesCollection.doc(employeeID).update({
          'uid': uid,
        });
      }
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'not-found':
          throw NotAnEmployeeException();
        default:
          throw GenericAuthException('Firestore Exception: ${error.message}');
      }
    } catch (e) {
      throw GenericAuthException('Other Exception: $e');
    }
  }
}
