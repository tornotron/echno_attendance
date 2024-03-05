import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/create_employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/delete_employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/update_employee.dart';

class HrEmployee extends Employee
    implements ICreateEmployee, IUpdateEmployee, IDeleteEmployee {
  HrEmployee({required super.user});

  @override
  Future createEmployee(
      {required String employeeId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) {
    return databaseService.createEmployee(
        employeeId: employeeId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future updateEmployee(
      {required String? employeeId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) {
    return databaseService.updateEmployee(
        employeeId: employeeId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future deleteEmployee({required String employeeId}) {
    return databaseService.deleteEmployee(employeeId: employeeId);
  }
}
