import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/employee/models/employee.dart';

class EmployeeService implements DatabaseHandler {
  final DatabaseHandler _handler;
  const EmployeeService(this._handler);

  factory EmployeeService.firestore() {
    return EmployeeService(FirestoreDatabaseHandler());
  }

  @override
  Future<Employee> get currentEmployee {
    return _handler.currentEmployee;
  }

  @override
  Future<void> createEmployee({
    required String employeeId,
    required String name,
    required String email,
    required String phoneNumber,
    required String userRole,
    required bool isActiveUser,
  }) {
    return _handler.createEmployee(
      employeeId: employeeId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      userRole: userRole,
      isActiveUser: isActiveUser,
    );
  }

  @override
  Future<void> deleteEmployee({required String employeeId}) {
    return _handler.deleteEmployee(employeeId: employeeId);
  }

  @override
  Future<Map<String, dynamic>> readEmployee({required String employeeId}) {
    return _handler.readEmployee(employeeId: employeeId);
  }

  @override
  Future<void> updateEmployee(
      {required String? employeeId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) {
    return _handler.updateEmployee(
      employeeId: employeeId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      userRole: userRole,
      isActiveUser: isActiveUser,
    );
  }

  @override
  Future<Map<String, dynamic>> searchEmployeeByUid({required String? uid}) {
    return _handler.searchEmployeeByUid(uid: uid);
  }
}
