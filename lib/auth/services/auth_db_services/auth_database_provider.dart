abstract class AuthDatabaseProvider {
  Future<Map<String, dynamic>> searchForEmployeeInFirestore(
      {required String employeeID});

  Future<void> updateUserUIDToFirestore(
      {required String employeeID, required String? uid});
}
