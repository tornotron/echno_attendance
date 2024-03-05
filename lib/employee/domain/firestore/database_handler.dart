import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/create_employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/delete_employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/read_employee.dart';
import 'package:echno_attendance/employee/services/crud_employee/update_employee.dart';

abstract class DatabaseHandler
    implements
        ICreateEmployee,
        IReadEmployee,
        IUpdateEmployee,
        IDeleteEmployee {
  Future<Map<String, dynamic>> searchEmployeeByUid({required String? uid});

  Future<Employee> get currentEmployee;
}
