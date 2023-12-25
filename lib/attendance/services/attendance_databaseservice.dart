import 'package:echno_attendance/attendance/services/attendance_databasepath.dart';
import 'package:sqflite/sqflite.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class AttendanceDatabaseServices {
  final logs = logger(AttendanceDatabaseServices, Level.info);
  Future<void> openCreateDatabase() async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      // await db.execute('''DROP TABLE attendance;''');
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS attendance(employee_id TEXT,employee_name TEXT,attendance_date TEXT,attendance_month TEXT,attendance_time TEXT,attendance_status TEXT);''');
    } catch (e) {
      logs.e('Error creating database');
    }
  }

  Future<void> insertIntoDatabase(
      {required String employeeId,
      required String employeeName,
      required String attendanceDate,
      required String? attendanceMonth,
      required String attendanceTime,
      required String attendanceStatus}) async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.insert('attendance', {
        'employee_id': employeeId,
        'employee_name': employeeName,
        'attendance_date': attendanceDate,
        'attendance_month': attendanceMonth,
        'attendance_time': attendanceTime,
        'attendance_status': attendanceStatus
      });
    } catch (e) {
      logs.e('Error inserting');
    }
  }

  Future<void> dropDatabase() async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.execute('''DROP TABLE attendance;''');
    } catch (e) {
      logs.e('Error dropping database');
    }
  }
}
