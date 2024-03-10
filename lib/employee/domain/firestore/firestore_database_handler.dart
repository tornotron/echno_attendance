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
        employeeRole = getEmployeeRole(employeeData['employee-role']);
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
        Map<String, dynamic> employeeData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        devtools.log('Employee found');
        return employeeData;
      } else {
        devtools.log('Employee not found');
        return {}; // Return an empty map if no employee is found
      }
    } catch (e) {
      devtools.log('Error searching for employee: $e');
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
  Future<Employee?> createEmployee(
      {required String employeeId,
      required String employeeName,
      required String companyEmail,
      required String phoneNumber,
      required EmployeeRole employeeRole,
      required bool employeeStatus}) async {
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
          'full-name': employeeName,
          'email-id': companyEmail,
          'phone': phoneNumber,
          'employee-role': employeeRole.toString().split('.').last,
          'employee-status': employeeStatus,
        });
        Employee employee = Employee(
          employeeId: employeeId,
          employeeName: employeeName,
          companyEmail: companyEmail,
          phoneNumber: phoneNumber,
          employeeStatus: employeeStatus,
          employeeRole: employeeRole,
        );
        return employee;
      } else {
        logs.i('user already exits');
      }
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
    return null;
  }

  @override
  Future<Employee?> updateEmployee({
    required String? employeeId,
    String? employeeName,
    String? companyEmail,
    String? phoneNumber,
    EmployeeRole? employeeRole,
    bool? employeeStatus,
  }) async {
    try {
      final employeeDocument =
          FirebaseFirestore.instance.collection('employees').doc(employeeId);
      final employeeDataSnapshot = await employeeDocument.get();

      final Map<String, dynamic> oldEmployeeData =
          employeeDataSnapshot.data() as Map<String, dynamic>;

      final newEmployeeData = <String, dynamic>{};

      if (employeeName != null) {
        newEmployeeData['full-name'] = employeeName;
      }

      if (companyEmail != null) {
        newEmployeeData['email-id'] = companyEmail;
      }

      if (phoneNumber != null) {
        newEmployeeData['phone'] = phoneNumber;
      }

      if (employeeRole != null) {
        newEmployeeData['employee-role'] =
            employeeRole.toString().split('.').last;
      }

      if (employeeStatus != null) {
        newEmployeeData['employee-status'] = employeeStatus;
      }

      await employeeDocument.update(newEmployeeData);

      Employee employee = Employee(
        employeeId: employeeId ?? oldEmployeeData['employee-id'],
        employeeName: oldEmployeeData['full-name'],
        companyEmail: oldEmployeeData['email-id'],
        phoneNumber: oldEmployeeData['phone'],
        employeeStatus: oldEmployeeData['employee-status'],
        employeeRole: getEmployeeRole(oldEmployeeData['employee-role']),
      );
      return employee;
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
    return null;
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
