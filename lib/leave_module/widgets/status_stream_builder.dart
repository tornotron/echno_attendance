import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/widgets/leave_status_card.dart';
import 'package:echno_attendance/utilities/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LeaveStatusStreamWidget extends StatefulWidget {
  const LeaveStatusStreamWidget({
    super.key,
  });

  @override
  State<LeaveStatusStreamWidget> createState() =>
      _LeaveStatusStreamWidgetState();
}

class _LeaveStatusStreamWidgetState extends State<LeaveStatusStreamWidget> {
  Employee? _currentEmployee;
  final leaveService = LeaveService.firestoreLeave();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final employee = await EmployeeService.firestore().currentEmployee;

      setState(() {
        _currentEmployee = employee;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = EchnoHelperFunctions.isDarkMode(context);
    return Expanded(
      child: StreamBuilder<List<Leave>>(
        stream: leaveService.streamLeaveHistory(
          authUserId: _currentEmployee?.authUserId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  const Center(child: LinearProgressIndicator()),
                  const SizedBox(height: 10),
                  Text(
                    leaveStatusLoadingText,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                leaveStatusNoLeaveData,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final orderedLeaves = snapshot.data!.toList()
              ..sort((a, b) => b.appliedDate.compareTo(a.appliedDate));
            return ListView.builder(
              itemCount: orderedLeaves.length,
              itemExtent: 180.0,
              itemBuilder: (context, index) {
                final leave = orderedLeaves[index];
                return leaveStatusCard(
                  leave,
                  isDark,
                  context,
                );
              },
            );
          }
        },
      ),
    );
  }
}
