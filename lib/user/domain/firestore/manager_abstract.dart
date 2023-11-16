abstract class UserHandleProvider {
  Future createUser(
      {required String userId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser});
  Future updateUser(
      {required String? userId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser});
  Future deleteUser({required String userId});
  Future<Map<String, dynamic>> readUser({required String userId});
}
