import 'package:echno_attendance/user/firestore/manager_abstract.dart';
import 'package:echno_attendance/user/firestore/userhandling_implementation.dart';

mixin ManagerMixin {
  final UserHandleProvider firestoreUserImplementation =
      FirestoreUserServices();

  Future<Map<String, dynamic>> readUser({required String userId}) {
    return firestoreUserImplementation.readUser(userId: userId);
  }
}
