import 'package:echno_attendance/auth/services/auth_services/auth_service.dart';
import 'package:echno_attendance/constants/leave_module_strings.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/services/leave_services.dart';
import 'package:echno_attendance/leave_module/widgets/leave_status_card.dart';
import 'package:flutter/material.dart';

Widget leaveStatusStreamBuilder({
  required bool isDarkMode,
  required BuildContext context,
}) {
  final currentUserId = AuthService.firebase().currentUser?.uid;
  final leaveProvider = LeaveService.firestoreLeave();
  return Expanded(
    child: StreamBuilder<List<Leave>>(
      stream: leaveProvider.streamLeaveHistory(uid: currentUserId),
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
