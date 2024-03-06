abstract class IUpdateEmployee {
  Future<void> updateEmployee({
    required String? employeeId,
    String? name,
    String? email,
    String? phoneNumber,
    String? userRole,
    bool? isActiveUser,
  });
}
