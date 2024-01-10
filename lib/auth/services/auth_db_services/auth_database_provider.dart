abstract class AuthDatabaseProvider {
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeID});

  Future<void> updateUserUIDToDatabase(
      {required String employeeID, required String? uid});
}
