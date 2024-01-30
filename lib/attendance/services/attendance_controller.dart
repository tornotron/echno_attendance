import 'package:echno_attendance/attendance/services/attendance_abstarct.dart';

class AttendanceController {
  final AttendanceHandleProvider repository;

  AttendanceController(this.repository);

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
