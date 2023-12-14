import 'package:flutter_test/flutter_test.dart';
import 'package:echno_attendance/attendance/services/attendance_databaseservice.dart';

void main() {
  group('AttendanceDatabase test', () {
    late AttendanceDatabaseServices database;

    setUp(() {
      database = AttendanceDatabaseServices();
    });

    test('DatabaseCreation test', () async {
      await expectLater(database.openCreateDatabase(), completes);
    });

    test('Insertion test with sample data', () async {
      await expectLater(
        database.insertIntoDatabase(
            employeeId: 1,
            employeeName: 'testname',
            attendanceDate: 'testdate',
            attendanceTime: 'testtime',
            attendanceStatus: 1),
        completes,
      );
    });
  });
}
