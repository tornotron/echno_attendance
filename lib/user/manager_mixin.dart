import 'package:echno_attendance/user/domain/firestore/manager_abstract.dart';
import 'package:echno_attendance/user/domain/firestore/userhandling_implementation.dart';

mixin ManagerMixin {
  final UserHandleProvider firestoreUserImplementation =
      FirestoreUserServices();

  Future<Map<String, dynamic>> readUser({required String userId}) {
    return firestoreUserImplementation.readUser(userId: userId);
  }
}
