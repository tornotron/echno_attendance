import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/attendance/services/attendance_abstarct.dart';
import 'package:echno_attendance/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AttendanceFirestoreService implements AttendanceHandleProvider {
  final logs = logger(AttendanceFirestoreService, Level.info);

  @override
  Future<void> insertIntoDatabase({
    required String employeeId,
    required String employeeName,
    required String attendanceDate,
    required String attendanceMonth,
    required String attendanceTime,
    required String attendanceStatus,
    required String siteName,
  }) async {
    try {
      List<int> dateComponents =
          attendanceDate.split('-').map((e) => int.parse(e)).toList();
      int year = dateComponents[0];
      int month = dateComponents[1];
      int day = dateComponents[2];

      List<int> timeComponents =
          attendanceTime.split(':').map((e) => int.parse(e)).toList();
      int hour = timeComponents[0];
      int minute = timeComponents[1];
      int second = timeComponents[2];

      DateTime combinedDate = DateTime(year, month, day, hour, minute, second);

      CollectionReference firestoreattendance =
          FirebaseFirestore.instance.collection('attendance');
      await firestoreattendance.doc(employeeId).set(
        {
          "employee_id": employeeId,
          "employee_name": employeeName,
        },
      );
      firestoreattendance
          .doc(employeeId)
          .collection('attendancedate')
          .doc(attendanceDate)
          .set(
        {
          "attendance_date": combinedDate,
          "attendance_month": attendanceMonth,
          "attendance_time": attendanceTime,
          "attendance_status": attendanceStatus,
          "site_name": siteName,
        },
      );
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
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
    final Map<String, int> monthMap = {
      'January': 1,
      'February': 2,
      'March': 3,
      'April': 4,
      'May': 5,
      'June': 6,
      'July': 7,
      'August': 8,
      'September': 9,
      'October': 10,
      'November': 11,
      'December': 12,
    };
    try {
      final attMonthint = monthMap[attendanceMonth];

      final endMonthday = monthdayMap[attendanceMonth];

      final startDate = DateTime(attYearint, attMonthint!, 1);
      final endDate =
          DateTime(attYearint, attMonthint, endMonthday!, 23, 59, 59);

      List<Map<String, dynamic>> attendanceList = [];
      Map<String, dynamic> namedata = {};
      CollectionReference firestoreattendance =
          FirebaseFirestore.instance.collection('attendance');
      final snapshot = firestoreattendance.doc(employeeId);
      final dateData = snapshot.collection('attendancedate');

      QuerySnapshot querySnapshot = await dateData
          .where('attendance_date', isGreaterThanOrEqualTo: startDate)
          .where('attendance_date', isLessThanOrEqualTo: endDate)
          .get();
      QuerySnapshot querySnapshotname = await firestoreattendance
          .where('employee_id', isEqualTo: employeeId)
          .get();
      querySnapshotname.docs.forEach((DocumentSnapshot document) {
        namedata = document.data() as Map<String, dynamic>;
      });
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        Timestamp t = data['attendance_date'];
        DateTime d = t.toDate();
        final dateString = d.toString();
        data['attendance_date'] = dateString;
        final combinedata = {...namedata, ...data};
        attendanceList.add(combinedata);
      });
      List<Map<String, String>> attendanceformattted = attendanceList
          .map(
              (row) => row.map((key, value) => MapEntry(key, value.toString())))
          .toList();

      return attendanceformattted;
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
    return [];
  }

  Future<int> daysInFebruary(int attYear) async {
    return (attYear % 4 == 0 && (attYear % 100 != 0 || attYear % 400 == 0))
        ? 29
        : 28;
  }

  @override
  Future<List<Map<String, String>>> fetchFromDatabaseDaily(
      {required String siteName, required String date}) async {
    FirebaseFirestore firestoredaily = FirebaseFirestore.instance;
    try {
      DateTime dateTimedaily = DateTime.parse(date);
      DateTime timestampStart = dateTimedaily;
      DateTime timestampEnd = dateTimedaily.add(const Duration(days: 1));
      List<Map<String, dynamic>> attendancedailyList = [];
      QuerySnapshot querySnapshotDaily = await firestoredaily
          .collectionGroup('attendancedate')
          .where('site_name', isEqualTo: siteName)
          .where('attendance_date', isGreaterThanOrEqualTo: timestampStart)
          .where('attendance_date', isLessThanOrEqualTo: timestampEnd)
          .get();
      querySnapshotDaily.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        attendancedailyList.add(data);
      });
      List<Map<String, String>> attendancedailyFormatted = attendancedailyList
          .map(
              (row) => row.map((key, value) => MapEntry(key, value.toString())))
          .toList();
      return attendancedailyFormatted;
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }

    return [];
  }
}
