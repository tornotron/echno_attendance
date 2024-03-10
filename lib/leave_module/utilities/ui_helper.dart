import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:flutter/material.dart';

// UI Helper Functions for LeaveStatusScreen

// Returns the icon based on the leave status and isCancelled
Icon getIcon(LeaveStatus? leaveStatus, bool isCancelled) {
  if (isCancelled) {
    return const Icon(
      Icons.report_outlined,
      size: 60,
      color: leaveStatusOrangeColor,
    );
  }
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return const Icon(
        Icons.check_circle_rounded,
        size: 60,
        color: echnoGreenColor,
      );
    case LeaveStatus.pending:
      return const Icon(
        Icons.hourglass_empty_rounded,
        size: 60,
        color: leaveStatusYellowColor,
      );
    case LeaveStatus.rejected:
      return const Icon(
        Icons.cancel,
        size: 60,
        color: leaveStatusRedColor,
      );
    default:
      return const Icon(
        Icons.hourglass_empty_rounded,
        size: 60,
        color: leaveStatusYellowColor,
      );
  }
}

// Returns the color based on the leave status and isCancelled
Color getColor(LeaveStatus? leaveStatus, bool isCancelled) {
  if (isCancelled) {
    return leaveStatusOrangeColor;
  }
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return echnoGreenColor;
    case LeaveStatus.pending:
      return leaveStatusYellowColor;
    case LeaveStatus.rejected:
      return leaveStatusRedColor;
    default:
      return leaveStatusYellowColor;
  }
}
