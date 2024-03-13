import 'package:echno_attendance/attendance/services/attendance_interface.dart';
import 'package:echno_attendance/attendance/services/attendance_databasepath.dart';
import 'package:sqflite/sqflite.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class AttendanceLocalRepository implements AttendanceRepositoryInterface {
  final logs = logger(AttendanceLocalRepository, Level.info);

  Future<void> openCreateDatabase() async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.execute(
          '''CREATE TABLE IF NOT EXISTS attendance(employee_id TEXT,employee_name TEXT,attendance_date TEXT,attendance_month TEXT,attendance_time TEXT,attendance_status TEXT);''');
    } catch (e) {
      logs.e('Error creating database');
    }
  }

  @override
  Future<void> insertIntoDatabase(
      {required String employeeId,
      required String employeeName,
      required String attendanceDate,
      required String? attendanceMonth,
      required String attendanceTime,
      required String attendanceStatus,
      required String siteName}) async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.insert('attendance', {
        'employee_id': employeeId,
        'employee_name': employeeName,
        'attendance_date': attendanceDate,
        'attendance_month': attendanceMonth,
        'attendance_time': attendanceTime,
        'attendance_status': attendanceStatus,
        'site_name': siteName,
      });
    } catch (e) {
      logs.e('Error inserting');
    }
  }

  @override
  Future<List<Map<String, String>>> fetchFromDatabase(
      {required String employeeId,
      required String attendanceMonth,
      required String attYear}) async {
    final attYearint = int.parse(attYear);
    final Map<String, int> monthdayMap = {
      'January': 31,
      'February': await daysInFebruary(attYearint),
      'March': 31,
      'April': 30,
      'May': 31,
      'June': 30,
      'July': 31,
      'August': 31,
      'September': 30,
      'October': 31,
      'November': 30,
      'December': 31,
    };
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      attYear = '%$attYear';
      List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM attendance WHERE employee_id = ? AND attendance_month = ? AND attendance_date LIKE ? ORDER BY attendance_date ASC LIMIT ?',
        [employeeId, attendanceMonth, attYear, monthdayMap[attendanceMonth]],
      );
      List<Map<String, String>> formattedResult = result
          .map(
              (row) => row.map((key, value) => MapEntry(key, value.toString())))
          .toList();
      return formattedResult;
    } catch (e) {
      logs.e('Error fetching from attendance database: $e');
    }
    return [];
  }

  @override
  Future<List<Map<String, String>>> fetchFromDatabaseDaily(
      {required String siteName, required String date}) async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM attendance WHERE site_name = ? AND attendance_date = ?',
        [siteName, date],
      );
      List<Map<String, String>> formattedResult = result
          .map(
              (row) => row.map((key, value) => MapEntry(key, value.toString())))
          .toList();
      return formattedResult;
    } catch (e) {
      logs.e('Error fetching from attendance(daily) database: $e');
    }
    return [];
  }

  Future<int> daysInFebruary(int attYear) async {
    return (attYear % 4 == 0 && (attYear % 100 != 0 || attYear % 400 == 0))
        ? 29
        : 28;
  }

  Future<void> dropDatabase() async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.execute('''DROP TABLE attendance''');
    } catch (e) {
      logs.e('Error dropping database');
    }
  }

  Future<void> dropTable() async {
    final path = await getAttendanceDatabasePath();
    try {
      final db = await openDatabase(path);
      await db.execute('''ALTER TABLE attendance ADD site_name TEXT''');
    } catch (e) {
      logs.e('Error deleting records');
    }
  }
}
