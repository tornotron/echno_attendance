import 'package:echno_attendance/employee/domain/firestore/manager_interface.dart';
import 'package:echno_attendance/employee/domain/firestore/userhandling_implementation.dart';
import 'package:echno_attendance/employee/services/crud/create_employee.dart';
import 'package:echno_attendance/employee/services/crud/delete_employee.dart';
import 'package:echno_attendance/employee/services/crud/read_employee.dart';
import 'package:echno_attendance/employee/services/crud/update_employee.dart';

class HrService
    implements
        ICreateEmployee,
        IReadEmployee,
        IUpdateEmployee,
        IDeleteEmployee {
  final UserHandlingInterface firestoreUserImplementation =
      UserFirestoreRepository();

  @override
  Future createEmployee(
      {required String employeeId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) {
    return firestoreUserImplementation.createUser(
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
    return firestoreUserImplementation.updateUser(
        employeeId: employeeId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future deleteEmployee({required String employeeId}) {
    return firestoreUserImplementation.deleteUser(employeeId: employeeId);
  }

  @override
  Future<Map<String, dynamic>> readEmployee({required String employeeId}) {
    return firestoreUserImplementation.readUser(employeeId: employeeId);
  }
}
