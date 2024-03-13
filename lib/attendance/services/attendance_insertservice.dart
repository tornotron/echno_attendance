import 'package:echno_attendance/attendance/domain/firestore/attendance_firestore_handler.dart';
import 'package:logger/logger.dart';
import 'package:echno_attendance/logger.dart';
import 'package:intl/intl.dart';

class AttendanceInsertionService {
  final logs = logger(AttendanceInsertionService, Level.info);
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
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    String monthNumber = formattedDate.substring(5, 7);
    String month = monthMap[monthNumber]!;

    String attendanceStatus = 'true';
    await AttendanceFirestoreRepository().insertIntoDatabase(
        employeeId: employeeId,
        employeeName: employeeName,
        attendanceDate: formattedDate,
        attendanceMonth: month,
        attendanceTime: formattedTime,
        attendanceStatus: attendanceStatus,
        siteName: siteName);
  }
}
