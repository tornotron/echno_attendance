import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/global_theme/text_style.dart';
import 'package:echno_attendance/user/hr_screens/attendance_report/attcard_daily.dart';
import 'package:echno_attendance/user/hr_screens/attendance_report/attcard_monthly.dart';
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
  bool showMainContent = true;

  TextEditingController employeeIdController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  String employeeIdfromUI = '';
  String attendanceMonthfromUI = '';
  String attendanceYearfromUI = '';

  @override
  void dispose() {
    employeeIdController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            //padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 60,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        setState(() {
                          showMainContent = true;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Get Monthly Report',
                        style: TextStyle(
                          fontFamily: 'TT Chocolates',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        setState(() {
                          showMainContent = false;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Get Daily Report',
                        style: TextStyle(
                          fontFamily: 'TT Chocolates',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF004AAD),
        ),
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
      body: showMainContent
          ? Column(
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
                          controller: employeeIdController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              labelText: 'Emp ID',
                              labelStyle:
                                  EchnoTextTheme.lightTextTheme.titleMedium),
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
                              labelStyle:
                                  EchnoTextTheme.lightTextTheme.titleMedium,
                            ),
                          ),
                          onChanged: (value) {
                            if (value == null) {
                            } else {
                              attendanceMonthfromUI = value;
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: yearController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelText: 'Year',
                            labelStyle:
                                EchnoTextTheme.lightTextTheme.titleMedium,
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
                      if (employeeIdController.text.isNotEmpty &&
                          attendanceMonthfromUI.isNotEmpty &&
                          yearController.text.isNotEmpty) {
                        setState(() {
                          employeeIdfromUI = employeeIdController.text;
                          attendanceMonthfromUI = attendanceMonthfromUI;
                          attendanceYearfromUI = yearController.text;
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
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
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
                  child: employeeIdfromUI.isNotEmpty &&
                          attendanceMonthfromUI.isNotEmpty &&
                          attendanceYearfromUI.isNotEmpty
                      ? AttendanceCardMonthly(
                          employeeId: employeeIdfromUI,
                          attendanceMonth: attendanceMonthfromUI,
                          attYear: attendanceYearfromUI,
                        )
                      : Container(
                          color: Colors.white,
                        ),
                ),
              ],
            )
          : const DailyReport(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: echnoBlueLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        child: const Text(
          "Change report type",
          style: TextStyle(
            fontFamily: 'TT Chocolates',
            color: echnoBlueColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

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
