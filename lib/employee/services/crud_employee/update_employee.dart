abstract class IUpdateEmployeeService {
  Future<void> updateEmployee({
    required String? employeeId,
    String? name,
    String? email,
    String? phoneNumber,
    String? userRole,
    bool? isActiveUser,
  });
}
