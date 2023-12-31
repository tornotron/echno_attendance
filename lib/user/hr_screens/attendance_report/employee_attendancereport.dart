import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:echno_attendance/user/hr_screens/attendance_report/attcard.dart';
import 'package:echno_attendance/user/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  TextEditingController searchControllerempId = TextEditingController();
  TextEditingController searchControllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xFF004AAD)),
        backgroundColor: echnoBlueColor,
        title: const Texts(
          textData: "Attendance Report",
          textFontSize: 23,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Get Attendance Report',
                    style: EchnoTextTheme.lightTextTheme.displaySmall)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.7),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Get Attendance Report',
                    style: EchnoTextTheme.lightTextTheme.titleMedium)),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: searchControllerempId,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: 'Employee ID',
                        labelStyle: EchnoTextTheme.lightTextTheme.titleMedium),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchControllerDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'Attendance month',
                    labelStyle: EchnoTextTheme.lightTextTheme.titleMedium,
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          AttendanceCard(
            employeeId: searchControllerempId.text,
            attendanceMonth: searchControllerDate.text,
            attYear: '2023',
          ),
        ],
      ),
    );
  }
}
