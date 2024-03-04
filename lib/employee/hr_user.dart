import 'package:echno_attendance/employee/domain/firestore/manager_interface.dart';
import 'package:echno_attendance/employee/domain/firestore/userhandling_implementation.dart';

class HrClass implements UserHandlingInterface {
  final UserHandlingInterface firestoreUserImplementation =
      UserFirestoreRepository();

  @override
  Future createUser(
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
  Future updateUser(
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
  Future deleteUser({required String employeeId}) {
    return firestoreUserImplementation.deleteUser(employeeId: employeeId);
  }

  @override
  Future<Map<String, dynamic>> readUser({required String employeeId}) {
    return firestoreUserImplementation.readUser(employeeId: employeeId);
  }
}
