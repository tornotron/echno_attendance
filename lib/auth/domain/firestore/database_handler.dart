abstract class DatabaseHandler {
  Future<void> updateUserUIDToDatabase(
      {required String employeeId, required String? uid});

  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeId});
}
