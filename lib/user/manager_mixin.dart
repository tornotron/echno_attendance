import 'package:echno_attendance/user/domain/firestore/manager_interface.dart';
import 'package:echno_attendance/user/domain/firestore/userhandling_implementation.dart';

mixin ManagerMixin {
  final UserHandlingInterface firestoreUserImplementation =
      UserFirestoreRepository();

  Future<Map<String, dynamic>> readUser({required String userId}) {
    return firestoreUserImplementation.readUser(employeeId: userId);
  }
}
