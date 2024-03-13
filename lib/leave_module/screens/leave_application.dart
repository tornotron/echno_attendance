import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:echno_attendance/leave_module/widgets/date_selection_field.dart';
import 'package:echno_attendance/leave_module/widgets/leave_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final _leaveHandler = LeaveService.firestoreLeave(); // Leave related services
  final GlobalKey<FormState> _leaveFormKey = GlobalKey<FormState>();

  late final Employee currentEmployee;

  DateTime? startDate; // Starting date of leave
  DateTime? endDate; // Ending date of leave

  LeaveType?
      _selectedLeaveType; // Variable to store selected leave type using radio buttons

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
          _startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
          endDate = null; // Reset end date when start date changes
          _endDateController.clear();
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
          _endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
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
  void initState() {
    super.initState();
    _fetchCurrentEmployee();
  }

  Future<void> _fetchCurrentEmployee() async {
    final employee = await EmployeeService.firestore().currentEmployee;
    setState(() {
      currentEmployee = employee;
    });
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
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
        child: Form(
          key: _leaveFormKey,
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
                  hintText: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                ),
                const SizedBox(height: 10.0),

                // Selection field the start date of leave
                CustomDateField(
                  controller: _startDateController,
                  label: 'Start Date',
                  hintText: startDate == null
                      ? startDateFieldHint
                      : DateFormat('dd-MM-yyyy').format(startDate!),
                  onTap: () {
                    _selectStartDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start date is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),

                // Selection field the end date of leave
                CustomDateField(
                  controller: _endDateController,
                  label: 'End Date',
                  hintText: endDate == null
                      ? endDateFieldHint
                      : DateFormat('dd-MM-yyyy').format(endDate!),
                  onTap: () {
                    _selectEndDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'End date is required';
                    }
                    return null;
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
                    String typeName = getLeaveTypeName(type);
                    return DropdownMenuItem<LeaveType>(
                      value: type,
                      child: Text(typeName),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select Leave Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a leave type';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter remarks';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15.0),

                // Button to submit leave application
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_leaveFormKey.currentState!.validate()) {
                        // Form is valid, submit the leave application
                        await _leaveHandler.applyForLeave(
                          authUserId: currentEmployee.authUserId,
                          employeeId: currentEmployee.employeeId,
                          employeeName: currentEmployee.employeeName,
                          appliedDate: DateTime.now(),
                          fromDate: startDate ?? DateTime.now(),
                          toDate: endDate ?? DateTime.now(),
                          leaveType:
                              _selectedLeaveType.toString().split('.').last,
                          siteOffice: 'Site Office',
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
                          _startDateController.clear();
                          _endDateController.clear();
                          _remarksController.clear();
                          startDate = null;
                          endDate = null;
                          _selectedLeaveType = null;
                        });
                      }
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
