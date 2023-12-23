import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:echno_attendance/user/hr_screens/attendance_report/attendancereport_data.dart';
import 'package:flutter/material.dart';

class AttCard extends StatelessWidget {
  final String employeeIdFilter;
  final String? attendanceStatusFilter;
  final String? attendanceDateFilter;
  const AttCard(
      {super.key,
      required this.employeeIdFilter,
      this.attendanceDateFilter,
      this.attendanceStatusFilter});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<Map<String, dynamic>>(
        future: ReportData().readData(
            employeeId: employeeIdFilter,
            attendanceDate: attendanceDateFilter,
            attendanceStatus: attendanceStatusFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.white,
            );
          } else {
            final dataMap = snapshot.data!;
            final List<Map<String, dynamic>> attendanceMapListLocal =
                dataMap['attendanceData'];
            return ListView.builder(
                itemCount: attendanceMapListLocal.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> attendanceData =
                      attendanceMapListLocal[index];
                  final String employeeName = dataMap['employee-name'];
                  final String employeePhone = dataMap['employee-phone'];
                  final String attendanceDate =
                      attendanceData['attendance_date'];
                  final String attendanceTime =
                      attendanceData['attendance_time'];
                  var attendanceStatus = attendanceData['attendance_status'];
                  if (attendanceStatus == 1) {
                    attendanceStatus = true;
                  } else {
                    attendanceStatus = false;
                  }
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          color: echnoBlueColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employeeName,
                                      style: EchnoTextTheme
                                          .lightTextTheme.displaySmall,
                                    ),
                                    const Text(
                                      "random",
                                    ),
                                  ],
                                ),
                                const Text(
                                  "random",
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Attendance Date",
                                        ),
                                        Text(
                                          attendanceDate,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Sign In Time",
                                        ),
                                        Text(
                                          attendanceTime,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AttendanceStatusWidget(
                                  colorSelect: attendanceStatus,
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                });
          }
        },
      ),
    );
  }
}

class AttendanceStatusWidget extends StatelessWidget {
  final bool colorSelect;
  const AttendanceStatusWidget({Key? key, required this.colorSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = colorSelect ? Colors.green : Colors.red;
    String status = colorSelect ? 'Present' : 'Absent';
    return Container(
      padding: EdgeInsets.all(2),
      width: 60,
      height: 30,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(status)),
    );
  }
}
