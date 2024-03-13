import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LeaveApprovalScreen extends StatefulWidget {
  final Leave leave;
  const LeaveApprovalScreen({
    super.key,
    required this.leave,
  });
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final _leaveHandler = LeaveService.firestoreLeave();
  late Leave leave;
  LeaveStatus? selectedLeaveStatus;

  late final Employee currentEmployee;

  Future<void> _fetchCurrentEmployee() async {
    final employee = await EmployeeService.firestore().currentEmployee;
    setState(() {
      currentEmployee = employee;
    });
  }

  @override
  void initState() {
    super.initState();
    leave = widget.leave;
    selectedLeaveStatus = leave.leaveStatus;
    _fetchCurrentEmployee();
  }

  @override
  Widget build(context) {
    Widget content = Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor),
        backgroundColor: isDarkMode ? echnoLightBlueColor : echnoBlueColor,
        title: const Text(leaveApprovalAppBarTitle),
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
          padding: LeaveApprovalScreen.containerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                leaveApprovalScreenTitle,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.left,
              ),
              Text(
                leaveApprovalSubtitle,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5.0),
              const Divider(height: 5.0),
              const SizedBox(height: 5.0),
              Text(
                employeeNameFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: leave.employeeName,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                employeeIdFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: leave.employeeID,
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                leaveApprovalStartDateFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: DateFormat('dd-MM-yyyy').format(leave.fromDate),
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                leaveApprovalEndDateFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: DateFormat('dd-MM-yyyy').format(leave.toDate),
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                leaveApprovalLeaveTypeFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3.0),
              TextFormField(
                enabled: false,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: getLeaveTypeName(leave.leaveType),
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                leaveApprovalStatusFieldLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 5.0),
              DropdownButtonFormField<LeaveStatus>(
                value: selectedLeaveStatus,
                onChanged: (LeaveStatus? newValue) {
                  setState(() {
                    selectedLeaveStatus = newValue;
                  });
                },
                items: LeaveStatus.values.map((LeaveStatus status) {
                  String statusName = getLeaveStatusName(status);
                  return DropdownMenuItem<LeaveStatus>(
                    value: status, // Use enum value here
                    child: Text(statusName),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  hintText: 'Select Leave Status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _leaveHandler.updateLeaveStatus(
                        leaveId: leave.id,
                        newStatus:
                            selectedLeaveStatus.toString().split('.').last);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: successGreenColor,
                          content: Text(leaveApprovalSuccessMessage),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    leaveApprovalButtonLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (currentEmployee.employeeRole != EmployeeRole.hr) {
      content = Text(
        'You are not authorized to access this Page. Please contact HR',
        style: Theme.of(context).textTheme.titleMedium,
      );
    }
    return content;
  }
}
