import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';

class HrEmployeeService extends EmployeeService implements HrDatabaseHandler {
  final HrDatabaseHandler _handler;
  const HrEmployeeService(this._handler) : super(_handler);

  factory HrEmployeeService.firestore() {
    return HrEmployeeService(HrFirestoreDatabaseHandler());
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
}
