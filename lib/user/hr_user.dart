import 'package:echno_attendance/user/domain/firestore/manager_abstract.dart';
import 'package:echno_attendance/user/domain/firestore/userhandling_implementation.dart';

class HrClass implements UserHandleProvider {
  final UserHandleProvider firestoreUserImplementation =
      FirestoreUserServices();

  @override
  Future createUser(
      {required String userId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser}) {
    return firestoreUserImplementation.createUser(
        userId: userId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future updateUser(
      {required String? userId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser}) {
    return firestoreUserImplementation.updateUser(
        userId: userId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser);
  }

  @override
  Future deleteUser({required String userId}) {
    return firestoreUserImplementation.deleteUser(userId: userId);
  }

  @override
  Future<Map<String, dynamic>> readUser({required String userId}) {
    return firestoreUserImplementation.readUser(userId: userId);
  }
}
