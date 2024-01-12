import 'package:echno_attendance/attendance/services/attendance_databaseservice.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:flutter/material.dart';

class AttendanceCardMonthly extends StatefulWidget {
  final String employeeId;
  final String attendanceMonth;
  final String attYear;
  const AttendanceCardMonthly(
      {Key? key,
      required this.employeeId,
      required this.attendanceMonth,
      required this.attYear})
      : super(key: key);
  @override
  State<AttendanceCardMonthly> createState() => _AttendanceCardMonthlyState();
}

class _AttendanceCardMonthlyState extends State<AttendanceCardMonthly> {
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
                // String varemployeeId = attendanceData['employee_id'].toString();
                String varemployeeName =
                    attendanceData['employee_name'].toString();
                String varattendanceDate =
                    attendanceData['attendance_date'].toString();
                String varattendanceDay = varattendanceDate.substring(0, 2);

                String varattendanceMonth =
                    attendanceData['attendance_month'].toString();
                String varattendanceTime =
                    attendanceData['attendance_time'].toString();
                varattendanceTime = varattendanceTime.substring(0, 5);
                // String varattendanceStatus =
                    // attendanceData['attendance_status'].toString();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: echnoBlueColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 120,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                              maxWidth: 105,
                            ),
                            width: 95,
                            height: 80,
                            decoration: BoxDecoration(
                              color: echnoBlueLightColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    varattendanceDay,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'TT Chocolates',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    varattendanceMonth,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'TT Chocolates',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              varemployeeName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'TT Chocolates',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Check-In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TT Chocolates',
                                          fontSize: 15),
                                    ),
                                    Text(
                                      varattendanceTime,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TT Chocolates'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      "Check-out",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TT Chocolates',
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "--:--",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TT Chocolates'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
