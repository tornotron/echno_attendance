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

  @override
  Future<Employee?> readEmployee({
    required String employeeId,
  }) async {
    String employeeName;
    String companyEmail;
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

        employeeName = employeeData['employee-name'];
        companyEmail = employeeData['comapany-email'];
        phoneNumber = employeeData['phone-number'];
        employeeRole = getEmployeeRole(employeeData['employee-role']);
        employeeStatus = employeeData['employee-status'];

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
          .where('auth-user-id', isEqualTo: authUserId)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> employeeData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        logs.i('Employee found');
        return employeeData;
      } else {
        logs.i('Employee not found');
        throw Exception('Employee Not Added to Employee Collection');
      }
    } catch (e) {
      logs.e('Error searching for employee: $e');
      throw Exception('Error searching for employee: $e');
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
          'employee-name': employeeName,
          'company-email': companyEmail,
          'phone-number': phoneNumber,
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
        newEmployeeData['employee-name'] = employeeName;
      }

      if (companyEmail != null) {
        newEmployeeData['company-email'] = companyEmail;
      }

      if (phoneNumber != null) {
        newEmployeeData['phone-number'] = phoneNumber;
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
        employeeName: oldEmployeeData['employee-name'],
        companyEmail: oldEmployeeData['company-email'],
        phoneNumber: oldEmployeeData['phone-number'],
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
