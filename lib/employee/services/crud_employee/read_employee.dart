abstract class IReadEmployeeService {
  Future<Map<String, dynamic>> readEmployee({required String employeeId});
}
