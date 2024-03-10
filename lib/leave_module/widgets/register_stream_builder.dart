import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:echno_attendance/leave_module/widgets/leave_register_card.dart';
import 'package:flutter/material.dart';

Widget leaveRegisterStreamBuilder({
  required bool isDarkMode,
  required TextEditingController searchController,
  required BuildContext context,
}) {
  final leaveHandler = LeaveService.firestoreLeave();
  return Expanded(
    child: StreamBuilder<List<Leave>>(
      stream: leaveHandler.fetchLeaves(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              leaveRegisterNoLeaveData,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          // Order leaves by latest applied date
          final orderedLeaves = snapshot.data!.toList()
            ..sort((a, b) => b.appliedDate.compareTo(a.appliedDate));

          // Filter leaves based on search query
          final filteredLeaves = orderedLeaves.where((leave) {
            final searchQuery = searchController.text.toLowerCase();
            return getLeaveTypeName(leave.leaveType)
                    .toLowerCase()
                    .contains(searchQuery) ||
                leave.employeeName.toLowerCase().contains(searchQuery) ||
                leave.employeeID.toLowerCase().contains(searchQuery) ||
                leave.leaveStatus!
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery);
          }).toList();

          if (filteredLeaves.isEmpty) {
            return Center(
              child: Text(
                'No leaves found matching the search criteria.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredLeaves.length,
            itemBuilder: (context, index) {
              final leave = filteredLeaves[index];
              return leaveRow(
                leave,
                isDarkMode,
                context,
              );
            },
          );
        }
      },
    ),
  );
}
