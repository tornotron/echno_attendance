import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';

class HrEmployeeService extends EmployeeService implements HrDatabaseHandler {
  final HrDatabaseHandler _handler;
  const HrEmployeeService(this._handler) : super(_handler);

  factory HrEmployeeService.firestore() {
    return HrEmployeeService(HrFirestoreDatabaseHandler());
  }

  @override
  Future<Employee?> createEmployee({
    required String employeeId,
    required String employeeName,
    required String companyEmail,
    required String phoneNumber,
    required EmployeeRole employeeRole,
    required bool employeeStatus,
  }) {
    return _handler.createEmployee(
      employeeId: employeeId,
      employeeName: employeeName,
      companyEmail: companyEmail,
      phoneNumber: phoneNumber,
      employeeRole: employeeRole,
      employeeStatus: employeeStatus,
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
