abstract class ICreateEmployee {
  Future<void> createEmployee({
    required String employeeId,
    required String name,
    required String email,
    required String phoneNumber,
    required String userRole,
    required bool isActiveUser,
  });
}
