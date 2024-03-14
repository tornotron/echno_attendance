import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/create_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/delete_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/read_employee.dart';
import 'package:echno_attendance/employee/domain/firestore/crud_employee/update_employee.dart';
import 'package:image_picker/image_picker.dart';

abstract class BasicEmployeeDatabaseHandler implements IReadEmployee {
  Future<Map<String, dynamic>> searchEmployeeByAuthUserId(
      {required String? authUserId});
  Future<Employee> get currentEmployee;
  Future<void> uploadImage(
      {required String imagePath,
      required String employeeId,
      required XFile image});
}

abstract class HrDatabaseHandler extends BasicEmployeeDatabaseHandler
    implements ICreateEmployee, IUpdateEmployee, IDeleteEmployee {}
