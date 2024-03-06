import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/employee/models/employee.dart';

class EmployeeService implements BasicEmployeeDatabaseHandler {
  final BasicEmployeeDatabaseHandler _handler;
  const EmployeeService(this._handler);

  factory EmployeeService.firestore() {
    return EmployeeService(BasicEmployeeFirestoreDatabaseHandler());
  }

  @override
  Future<Employee> get currentEmployee {
    return _handler.currentEmployee;
  }

  @override
  Future<Map<String, dynamic>> readEmployee({required String employeeId}) {
    return _handler.readEmployee(employeeId: employeeId);
  }

  @override
  Future<Map<String, dynamic>> searchEmployeeByAuthUserId(
      {required String? uid}) {
    return _handler.searchEmployeeByAuthUserId(uid: uid);
  }
}
