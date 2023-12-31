import 'package:echno_attendance/attendance/services/attendance_databaseservice.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/user/hr_user.dart';
import 'package:flutter/material.dart';

class AttendanceCard extends StatefulWidget {
  final String employeeId;
  final String attendanceMonth;
  final String attYear;
  AttendanceCard(
      {Key? key,
      required this.employeeId,
      required this.attendanceMonth,
      required this.attYear})
      : super(key: key);
  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  Future<Map<String, dynamic>> getAttData(
      {required String employeeId,
      required String attendanceMonth,
      required String attYear}) async {
    // final emdtl = await HrClass().readUser(userId: employeeId);
    // if (emdtl.isEmpty) {
    //   return {};
    // }

    final attendanceData = await AttendanceDatabaseServices().fetchFromDatabase(
        employeeId: employeeId,
        attendanceMonth: attendanceMonth,
        attYear: attYear);

    if (attendanceData.isEmpty) {
      return {};
    }

    return {
      'attendanceData': attendanceData,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getAttData(
            employeeId: widget.employeeId,
            attendanceMonth: widget.attendanceMonth,
            attYear: widget.attYear),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.white,
            );
          } else {
            final dataMap = snapshot.data!;
            final List<Map<String, String>> attendanceMapList =
                dataMap['attendanceData'];
            return ListView.builder(
              itemCount: attendanceMapList.length,
              itemBuilder: (context, index) {
                final Map<String, String> attendanceData =
                    attendanceMapList[index];
                final String? varemployeeId = attendanceData['employee_id'];
                final String? varemployeeName = attendanceData['employee_name'];
                final String? varattendanceDate =
                    attendanceData['attendance_date'];
                final String? varattendanceMonth =
                    attendanceData['attendance_month'];
                final String? varattendanceTime =
                    attendanceData['attendance_time'];
                final String? varattendanceStatus =
                    attendanceData['attendance_status'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: echnoBlueColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 100,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
