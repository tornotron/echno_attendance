import 'package:echno_attendance/attendance/services/attendance_Localdatabaseservice.dart';
import 'package:logger/logger.dart';
import 'package:echno_attendance/logger.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  final logs = logger(AttendanceService, Level.info);
  final Map<String, String> monthMap = {
    '01': 'January',
    '02': 'February',
    '03': 'March',
    '04': 'April',
    '05': 'May',
    '06': 'June',
    '07': 'July',
    '08': 'August',
    '09': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December',
  };

  Future<void> attendanceTrigger(
      {required String employeeId,
      required String employeeName,
      required String siteName}) async {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);

    String monthNumber = formattedDate.substring(3, 5);
    String? Month = monthMap[monthNumber];

    String attendanceStatus = 'true';
    await AttendanceLocalServices().insertIntoDatabase(
        employeeId: employeeId,
        employeeName: employeeName,
        attendanceDate: formattedDate,
        attendanceMonth: Month,
        attendanceTime: formattedTime,
        attendanceStatus: attendanceStatus,
        siteName: siteName);
  }
}
