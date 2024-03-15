import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:echno_attendance/employee/widgets/attcard_daily.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({
    super.key,
  });

  @override
  State<DailyReport> createState() => _DailyState();
}

class _DailyState extends State<DailyReport> {
  TextEditingController siteController = TextEditingController();
  DatePickerController datevisualController = DatePickerController();

  void _scrolltoday() {
    datevisualController.animateToDate(DateTime.now());
  }

  String siteNamefromUI = '';
  String dateFromUI = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Daily Attendance Report',
                  style: EchnoTextTheme.lightTextTheme.displaySmall)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.7),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Get daily attendance report',
                  style: EchnoTextTheme.lightTextTheme.titleMedium)),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: siteController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Enter Employee Site Name',
                      labelStyle: EchnoTextTheme.lightTextTheme.titleMedium),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              height: 90,
              width: 300,
              child: DatePicker(
                DateTime.now().subtract(const Duration(days: 30)),
                initialSelectedDate: DateTime.now(),
                controller: datevisualController,
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (selectedDate) {
                  dateFromUI = DateFormat('yyyy-MM-dd').format(selectedDate);
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 90,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: echnoBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _scrolltoday();
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    fontFamily: 'TT Chocolates',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                siteNamefromUI = siteController.text;
                dateFromUI;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: echnoBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'TT Chocolates',
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        AttendanceCardDaily(siteName: siteNamefromUI, date: dateFromUI),
      ],
    );
  }
}
