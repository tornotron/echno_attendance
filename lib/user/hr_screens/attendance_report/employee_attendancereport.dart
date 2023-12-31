import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/user/hr_screens/attendance_report/attcard.dart';
import 'package:echno_attendance/user/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  TextEditingController searchControllerempId = TextEditingController();
  TextEditingController searchControllerDate = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        searchControllerDate.text = formattedDate;
      });
    }
  }

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
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
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
                        labelText: 'Employee ID'),
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
                      labelText: 'Attendance month'),
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
