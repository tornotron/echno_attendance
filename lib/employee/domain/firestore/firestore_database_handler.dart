import 'package:echno_attendance/auth/services/auth_services/auth_service.dart';
import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class BasicEmployeeFirestoreDatabaseHandler
    implements BasicEmployeeDatabaseHandler {
  final logs = logger(BasicEmployeeFirestoreDatabaseHandler, Level.info);
  get devtools => null;

  @override
  Future<Map<String, dynamic>> readEmployee({
    required String? employeeId,
  }) async {
    String? name, email, phoneNumber, userRole, id;
    bool? isActiveUser;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeId).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;
        id = employeeData['employee-id'];
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
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
      'isActiveUser': isActiveUser,
    };
  }

  @override
  Future<Map<String, dynamic>> searchEmployeeByUid(
      {required String? uid}) async {
    try {
      // Search user with reference to the uid in firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
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

  @override
  Future<Employee> get currentEmployee async {
    final user = AuthService.firebase().currentUser!;
    Employee employee = Employee.fromFirebaseUser(user);
    await employee.fetchAndUpdateEmployeeDetails();
    return employee;
  }
}

class HrFirestoreDatabaseHandler extends BasicEmployeeFirestoreDatabaseHandler
    implements HrDatabaseHandler {
  @override
  final logs = logger(HrFirestoreDatabaseHandler, Level.info);

  @override
  Future createEmployee(
      {required String employeeId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot useridCheck = await userCollection.doc(employeeId).get();

      if (!useridCheck.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(employeeId)
            .set({
          'employee-id': employeeId,
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
  Future updateEmployee(
      {required String? employeeId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(employeeId);

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
  Future deleteEmployee({required String employeeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(employeeId)
          .delete();
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }
}
