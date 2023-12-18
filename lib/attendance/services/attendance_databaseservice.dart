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
          '''CREATE TABLE IF NOT EXISTS attendance(employee_id INTEGER,employee_name TEXT,attendance_date TEXT,attendance_time TEXT,attendance_status INTEGER);''');
    } catch (e) {
      logs.e('Error creating database');
    }
  }

  Future<void> insertIntoDatabase(
      {required int employeeId,
      required String employeeName,
      required String attendanceDate,
      required String attendanceTime,
      required int attendanceStatus}) async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.insert('attendance', {
        'employee_id': employeeId,
        'employee_name': employeeName,
        'attendance_date': attendanceDate,
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
