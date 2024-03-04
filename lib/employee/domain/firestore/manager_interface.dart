import 'package:echno_attendance/employee/services/crud/create_employee.dart';
import 'package:echno_attendance/employee/services/crud/delete_employee.dart';
import 'package:echno_attendance/employee/services/crud/read_employee.dart';
import 'package:echno_attendance/employee/services/crud/update_employee.dart';

abstract class DatabaseHandler
    implements
        ICreateEmployee,
        IReadEmployee,
        IUpdateEmployee,
        IDeleteEmployee {}
