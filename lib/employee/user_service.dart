import 'package:echno_attendance/employee/domain/firestore/manager_interface.dart';
import 'package:echno_attendance/employee/domain/firestore/userhandling_implementation.dart';
import 'package:echno_attendance/employee/services/crud/read_employee.dart';

class UserService implements IReadEmployee {
  final UserHandlingInterface firestoreUserImplementation =
      UserFirestoreRepository();

  @override
  Future<Map<String, dynamic>> readEmployee({required String employeeId}) {
    return firestoreUserImplementation.readUser(employeeId: employeeId);
  }
}
