import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/crud/create_employee.dart';
import 'package:echno_attendance/employee/services/crud/delete_employee.dart';
import 'package:echno_attendance/employee/services/crud/update_employee.dart';

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
    return firestoreUserImplementation.createEmployee(
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
    return firestoreUserImplementation.updateEmployee(
        employeeId: employeeId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future deleteEmployee({required String employeeId}) {
    return firestoreUserImplementation.deleteEmployee(employeeId: employeeId);
  }
}
