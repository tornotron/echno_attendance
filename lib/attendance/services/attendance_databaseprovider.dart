import 'package:echno_attendance/attendance/services/attendance_pathprovider.dart';
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
          '''CREATE TABLE IF NOT EXISTS attendance(employee_id INTEGER,attendance_date TEXT,attendance_status INTEGER);''');
    } catch (e) {
      logs.e('Error creating database');
    }
  }

  Future<void> insertIntoDatabase(
      {required int employeeId,
      required String attendanceDate,
      required int attendanceStatus}) async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.insert('attendance', {
        'employee_id': employeeId,
        'attendance_date': attendanceDate,
        'attendance_status': attendanceStatus
      });
    } catch (e) {
      logs.e('Error inserting');
    }
  }

  Future<void> displayDatabaseContents() async {
    final path = await getAttendanceDatabasePath();
    final database = await openDatabase(path, version: 1);

    final results = await database.query('attendance');
    if (results.isNotEmpty) {
      results.forEach((row) {
        print(row);
      });
    } else {
      print('No data in the database');
    }
  }
}
