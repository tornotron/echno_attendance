import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/create_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/delete_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/read_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/update_employee.dart';

abstract class BasicEmployeeDatabaseHandler implements IReadEmployee {
  Future<Map<String, dynamic>> searchEmployeeByUid({required String? uid});
  Future<Employee> get currentEmployee;
}

abstract class HrDatabaseHandler extends BasicEmployeeDatabaseHandler
    implements ICreateEmployee, IUpdateEmployee, IDeleteEmployee {}
