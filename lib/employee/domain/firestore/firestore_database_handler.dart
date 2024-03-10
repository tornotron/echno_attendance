import 'package:echno_attendance/auth/services/auth_services/auth_service.dart';
import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class BasicEmployeeFirestoreDatabaseHandler
    implements BasicEmployeeDatabaseHandler {
  final logs = logger(BasicEmployeeFirestoreDatabaseHandler, Level.info);
  get devtools => null;

  @override
  Future<Employee?> readEmployee({
    required String employeeId,
  }) async {
    String employeeName;
    String employeeEmail;
    String phoneNumber;
    bool employeeStatus;
    EmployeeRole employeeRole;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('employees');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeId).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;

        employeeName = employeeData['full-name'];
        employeeEmail = employeeData['email-id'];
        phoneNumber = employeeData['phone'];
        employeeRole = employeeData['employee-role'];
        employeeStatus = employeeData['employee-status'];

        Employee employee = Employee(
          employeeId: employeeId,
          employeeName: employeeName,
          companyEmail: employeeEmail,
          phoneNumber: phoneNumber,
          employeeStatus: employeeStatus,
          employeeRole: employeeRole,
        );
        return employee;
      } else {
        logs.i("employee doesn't exist");
      }
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>> searchEmployeeByAuthUserId(
      {required String? authUserId}) async {
    try {
      // Search user with reference to the uid in firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .where('uid', isEqualTo: authUserId)
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
    Employee employee = await Employee.fromFirebaseUser(user);
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
      required String companyEmail,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('employees');

      DocumentSnapshot useridCheck = await userCollection.doc(employeeId).get();

      if (!useridCheck.exists) {
        await FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeId)
            .set({
          'employee-id': employeeId,
          'full-name': name,
          'email-id': companyEmail,
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
          FirebaseFirestore.instance.collection('employees').doc(employeeId);

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
          .collection('employees')
          .doc(employeeId)
          .delete();
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }
}
