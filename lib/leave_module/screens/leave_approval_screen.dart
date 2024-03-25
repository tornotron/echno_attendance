import 'package:echno_attendance/common_widgets/custom_app_bar.dart';
import 'package:echno_attendance/constants/colors.dart';
import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/constants/sizes.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/employee/utilities/employee_role.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:echno_attendance/leave_module/widgets/leave_form_field.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:echno_attendance/utilities/styles/padding_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveApprovalScreen extends StatefulWidget {
  final Leave leave;
  const LeaveApprovalScreen({
    super.key,
    required this.leave,
  });

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  final _leaveHandler = LeaveService.firestoreLeave();
  late Leave leave;
  LeaveStatus? selectedLeaveStatus;
  final TextEditingController _remarksController = TextEditingController();

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
    _remarksController.text = leave.remarks!;
  }

  @override
  Widget build(context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);

    Widget content = Column(
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
        const SizedBox(height: EchnoSize.spaceBtwSections),
        const Divider(height: EchnoSize.dividerHeight),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Employee Name',
          isReadOnly: true,
          hintText: currentEmployee.employeeName,
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Employee ID',
          isReadOnly: true,
          hintText: currentEmployee.employeeId,
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Leave From',
          isReadOnly: true,
          hintText: DateFormat('dd-MM-yyyy').format(leave.fromDate),
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Leave Till',
          isReadOnly: true,
          hintText: DateFormat('dd-MM-yyyy').format(leave.toDate),
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Leave Type',
          isReadOnly: true,
          hintText: getLeaveTypeName(leave.leaveType),
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
        LeaveFormField(
          mainLabel: 'Remarks',
          isReadOnly: true,
          maxLines: null,
          minLines: 3,
          controller: _remarksController,
        ),
        const SizedBox(height: EchnoSize.spaceBtwItems),
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
        const SizedBox(height: EchnoSize.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await _leaveHandler.updateLeaveStatus(
                  leaveId: leave.leaveId,
                  newStatus: selectedLeaveStatus.toString().split('.').last);
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
    );
    if (currentEmployee.employeeRole != EmployeeRole.hr) {
      content = Center(
        child: Text(
          'You are not authorized to access this Page. Please contact HR',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      appBar: EchnoAppBar(
        leadingIcon: Icons.arrow_back_ios_new,
        leadingOnPressed: () {
          Navigator.pop(context);
        },
        title: Text(
          'Leave Sanction',
          style: Theme.of(context).textTheme.headlineSmall?.apply(
                color: isDark ? EchnoColors.black : EchnoColors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: CustomPaddingStyle.defaultPaddingWithAppbar,
          child: content,
        ),
      ),
    );
  }
}
