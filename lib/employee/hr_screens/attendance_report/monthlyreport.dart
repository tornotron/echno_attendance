import 'package:dropdown_search/dropdown_search.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:echno_attendance/employee/widgets/attcard_monthly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonthlyReport extends StatefulWidget {
   MonthlyReport(
      {super.key,
      required this.employeeIdController,
      required this.yearController,
      required this.employeeIdfromUI,
      required this.attendanceMonthfromUI,
      required this.attendanceYearfromUI});

  TextEditingController employeeIdController;
  TextEditingController yearController;
  String employeeIdfromUI;
  String attendanceMonthfromUI;
  String attendanceYearfromUI;

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> {
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
            child: Text('Monthly Attendance Report',
                style: EchnoTextTheme.lightTextTheme.displaySmall),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13.7),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Get monthly attendance report',
                style: EchnoTextTheme.lightTextTheme.titleMedium),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: widget.employeeIdController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Emp ID',
                      labelStyle: EchnoTextTheme.lightTextTheme.titleMedium),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: const [
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                  ],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Month',
                      labelStyle: EchnoTextTheme.lightTextTheme.titleMedium,
                    ),
                  ),
                  onChanged: (value) {
                    if (value == null) {
                    } else {
                      widget.attendanceMonthfromUI = value;
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: widget.yearController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'Year',
                    labelStyle: EchnoTextTheme.lightTextTheme.titleMedium,
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
              if (widget.employeeIdController.text.isNotEmpty &&
                  widget.attendanceMonthfromUI.isNotEmpty &&
                  widget.yearController.text.isNotEmpty) {
                setState(() {
                  widget.employeeIdfromUI = widget.employeeIdController.text;
                  widget.attendanceMonthfromUI = widget.attendanceMonthfromUI;
                  widget.attendanceYearfromUI = widget.yearController.text;
                });
              } else {
                setState(() {});
              }
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
        Container(
          child: widget.employeeIdfromUI.isNotEmpty &&
                  widget.attendanceMonthfromUI.isNotEmpty &&
                  widget.attendanceYearfromUI.isNotEmpty
              ? AttendanceCardMonthly(
                  employeeId: widget.employeeIdfromUI,
                  attendanceMonth: widget.attendanceMonthfromUI,
                  attYear: widget.attendanceYearfromUI,
                )
              : Container(
                  color: Colors.white,
                ),
        ),
      ],
    );
  }
}
