abstract class UserHandlingInterface {
  Future createUser(
      {required String employeeId,
      required String name,
      required String email,
      required String phoneNumber,
      required String userRole,
      required bool isActiveUser});
  Future updateUser(
      {required String? employeeId,
      String? name,
      String? email,
      String? phoneNumber,
      String? userRole,
      bool? isActiveUser});
  Future deleteUser({required String employeeId});
  Future<Map<String, dynamic>> readUser({required String employeeId});
}
