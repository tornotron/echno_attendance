import 'package:echno_attendance/employee/models/employee.dart';

abstract class IReadEmployee {
  Future<Employee?> readEmployee({required String employeeId});
}
