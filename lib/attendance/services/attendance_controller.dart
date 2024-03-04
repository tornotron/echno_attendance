import 'package:echno_attendance/attendance/services/attendance_interface.dart';

class AttendanceDatabaseController {
  final AttendanceRepositoryInterface repository;

  AttendanceDatabaseController(this.repository);

  Future<void> insertIntoDatabase(
      {required String employeeId,
      required String employeeName,
      required String attendanceDate,
      required String attendanceMonth,
      required String attendanceTime,
      required String attendanceStatus,
      required String siteName}) {
    return repository.insertIntoDatabase(
        employeeId: employeeId,
        employeeName: employeeName,
        attendanceDate: attendanceDate,
        attendanceMonth: attendanceMonth,
        attendanceTime: attendanceTime,
        attendanceStatus: attendanceStatus,
        siteName: siteName);
  }

  Future<List<Map<String, String>>> fetchFromDatabase(
      {required String employeeId,
      required String attendanceMonth,
      required String attYear}) {
    return repository.fetchFromDatabase(
        employeeId: employeeId,
        attendanceMonth: attendanceMonth,
        attYear: attYear);
  }

  Future<List<Map<String, String>>> fetchFromDatabaseDaily(
      {required String siteName, required String date}) {
    return repository.fetchFromDatabaseDaily(siteName: siteName, date: date);
  }
}
