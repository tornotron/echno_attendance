import 'package:echno_attendance/auth/services/auth_services/auth_service.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/widgets/date_selection_field.dart';
import 'package:echno_attendance/leave_module/widgets/leave_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({super.key});
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final TextEditingController _remarksController = TextEditingController();
  final leaveProvider = LeaveService.firestoreLeave(); // Leave related services

  DateTime? startDate; // Starting date of leave
  DateTime? endDate; // Ending date of leave

  LeaveType?
      _selectedLeaveType; // Variable to store selected leave type using radio buttons

  String getLeaveType(LeaveType type) {
    switch (type) {
      case LeaveType.ml:
        return 'Maternity Leave';
      case LeaveType.al:
        return 'Annual Leave';
      case LeaveType.cl:
        return 'Casual Leave';
      case LeaveType.sl:
        return 'Sick Leave';
      case LeaveType.pl:
        return 'Paternity Leave';
      case LeaveType.unclassified:
        return 'Unclassified';
    }
  }

  // Function selects the start date of leave
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (picked.isBefore(DateTime.now())) {
        // Show error dialog for start date before current date
        _showErrorDialog(startDateErrorMessage);
      } else {
        setState(() {
          startDate = picked;
          endDate = null; // Reset end date when start date changes
        });
      }
    }
  }

  // Function selects the end date of leave
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && startDate != null) {
      if (picked.isBefore(startDate!)) {
        _showErrorDialog(endDateErrorMessage);
      } else {
        setState(() {
          endDate = picked;
        });
      }
    }
  }

  // Function to calculate the number of days on leave
  String? calculateLeaveDays() {
    if (startDate != null && endDate != null) {
      return (endDate!.difference(startDate!).inDays + 1).toString();
    } else {
      return '-';
    }
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: errorRedColor),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
                  isDarkMode ? echnoLightBlueColor : echnoBlueColor),
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
          title: const Text(leaveApplicationAppBarTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: LeaveApplicationScreen.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  leaveApplicationScreenTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
                Text(
                  leaveApplicationSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 3.0),
                const SizedBox(height: 10.0),

                // The immediate supervisor of the employee
                const LeaveFormField(
                  mainLabel: coordinatorFieldLabel,
                  isReadOnly: true,
                  hintText: 'Alex Mercer', // This should be fetched from DB
                ),
                const SizedBox(height: 10.0),

                // Current Date
                LeaveFormField(
                  mainLabel: currentDateFieldLabel,
                  isReadOnly: true,
                  hintText:
                      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                ),
                const SizedBox(height: 10.0),

                // Selection field the start date of leave
                CustomDateField(
                  label: 'Start Date',
                  hintText: startDate == null
                      ? startDateFieldHint
                      : "${startDate!.day}-${startDate!.month}-${startDate!.year}",
                  onTap: () {
                    _selectStartDate(context);
                  },
                ),
                const SizedBox(height: 10.0),

                // Selection field the end date of leave
                CustomDateField(
                  label: 'End Date',
                  hintText: endDate == null
                      ? endDateFieldHint
                      : "${endDate!.day}-${endDate!.month}-${endDate!.year}",
                  onTap: () {
                    _selectEndDate(context);
                  },
                ),
                const SizedBox(height: 10.0),

                // Number of days on leave calculated from start and end date
                Text(
                  "$calculateDaysFieldLabel ${calculateLeaveDays()}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10.0),

                // Dropdoen to select Leave Type
                Text(
                  leaveTypeFieldLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5.0),
                DropdownButtonFormField<LeaveType>(
                  value: _selectedLeaveType,
                  onChanged: (LeaveType? newValue) {
                    setState(() {
                      _selectedLeaveType = newValue;
                    });
                  },
                  items: LeaveType.values.map((LeaveType type) {
                    String typeName = getLeaveType(type);
                    return DropdownMenuItem<LeaveType>(
                      value: type,
                      child: Text(typeName),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select Leave Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),

                // Text field to enter remarks
                Text(
                  remarksFieldLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  controller: _remarksController,
                  minLines: 5,
                  maxLines: null, // Allows for an adjustable number of lines
                  decoration: const InputDecoration(
                    hintText: remarksFieldHint,
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15.0),

                // Button to submit leave application
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final currentUser =
                          await AuthService.firebase().currentEmployee;

                      await leaveProvider.applyForLeave(
                        uid: currentUser!.uid!,
                        employeeID: currentUser.employeeID!,
                        employeeName: currentUser.employeeName!,
                        appliedDate:
                            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        fromDate:
                            "${startDate!.day}-${startDate!.month}-${startDate!.year}",
                        toDate:
                            "${endDate!.day}-${endDate!.month}-${endDate!.year}",
                        leaveType:
                            _selectedLeaveType.toString().split('.').last,
                        remarks: _remarksController.text,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: successGreenColor,
                            content: Text(leaveApplicationSuccessMessage),
                          ),
                        );
                      }

                      // Clear the fields on successful submission of leave
                      setState(() {
                        _remarksController.clear();
                        startDate = null;
                        endDate = null;
                        _selectedLeaveType = null;
                      });
                    },
                    child: const Text(
                      submitButtonLabel,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
