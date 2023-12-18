import 'package:echno_attendance/attendance/services/attendance_databaseservice.dart';
import 'package:logger/logger.dart';
import 'package:echno_attendance/logger.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  final logs = logger(AttendanceService, Level.info);
  Future<void> attendanceTrigger(
      {required String employeeId,
      required String employeeName,
      required int attendanceStatus}) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    await AttendanceDatabaseServices().insertIntoDatabase(
        employeeId: employeeId,
        employeeName: employeeName,
        attendanceDate: formattedDate,
        attendanceTime: formattedTime,
        attendanceStatus: attendanceStatus);
  }
}
