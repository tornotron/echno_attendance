abstract class DatabaseHandler {
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeId});

  Future<void> updateUserUIDToDatabase(
      {required String employeeId, required String? uid});
}
