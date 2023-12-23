import 'package:echno_attendance/attendance/services/attendance_databaseservice.dart';
import 'package:echno_attendance/user/hr_user.dart';

class ReportData {
  Future<Map<String, dynamic>> readData(
      {required String employeeId,
      String? attendanceStatus,
      String? attendanceDate}) async {
    final empdtl = await HrClass().readUser(employeeId: employeeId);
    if (empdtl.isEmpty) {
      return {};
    }
    final attendanceData = await AttendanceDatabaseServices().getfromDatabase(
        employeeId: employeeId,
        attendanceStatus: attendanceStatus,
        attendanceDate: attendanceDate);

    if (attendanceData.isEmpty) {
      return {};
    }

    return {
      'employee-id': empdtl['id'],
      'employee-name': empdtl['name'],
      'employee-phone': empdtl['phoneNumber'],
      'attendanceData': attendanceData,
    };
  }
}
