import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:flutter/material.dart';

class LeaveApprovalScreen extends StatefulWidget {
  final Map<String, dynamic> leaveData;
  const LeaveApprovalScreen({Key? key, required this.leaveData})
      : super(key: key);
  static const EdgeInsetsGeometry containerPadding =
      EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0);

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  get isDarkMode => Theme.of(context).brightness == Brightness.dark;
  final _leaveProvider = LeaveService.firestoreLeave();
  Map<String, dynamic> get leaveData => widget.leaveData;
  String? selectedLeaveStatus;

  @override
  void initState() {
    super.initState();
    selectedLeaveStatus = leaveData['leaveStatus'];
  }

  @override
  Widget build(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? echnoLightBlueColor : echnoLogoColor,
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
                    labelText: leaveData['employeeName'],
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
                    labelText: leaveData['employee-id'],
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
                    labelText: leaveData['fromDate'],
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
                    labelText: leaveData['toDate'],
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
                    labelText: leaveData['leaveType'],
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
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: echnoGreyColor,
                      width: 1.50,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(leaveApprovalApprovedRadioButton),
                        leading: Radio(
                          value: 'approved',
                          groupValue: selectedLeaveStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedLeaveStatus = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(leaveApprovalPendingRadioButton),
                        leading: Radio(
                          value: 'pending',
                          groupValue: selectedLeaveStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedLeaveStatus = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(leaveApprovalRejectedRadioButton),
                        leading: Radio(
                          value: 'rejected',
                          groupValue: selectedLeaveStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedLeaveStatus = value.toString();
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(leaveApprovalUnclassifiedRadioButton),
                        leading: Radio(
                          value: 'unclassified',
                          groupValue: selectedLeaveStatus,
                          onChanged: (value) {
                            setState(() {
                              selectedLeaveStatus = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _leaveProvider.updateLeaveStatus(
                          leaveId: leaveData['leave-id'],
                          newStatus: selectedLeaveStatus!);
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
      ),
    );
  }
}
