import 'package:echno_attendance/constants/colors.dart';
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
      color: EchnoColors.leaveStatusCancelled,
    );
  }
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return const Icon(
        Icons.check_circle_rounded,
        size: 60,
        color: EchnoColors.leaveStatusApproved,
      );
    case LeaveStatus.pending:
      return const Icon(
        Icons.hourglass_empty_rounded,
        size: 60,
        color: EchnoColors.leaveStatusPending,
      );
    case LeaveStatus.rejected:
      return const Icon(
        Icons.cancel,
        size: 60,
        color: EchnoColors.leaveStatusRejected,
      );
    default:
      return const Icon(
        Icons.hourglass_empty_rounded,
        size: 60,
        color: EchnoColors.leaveStatusPending,
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
      return EchnoColors.leaveStatusApproved;
    case LeaveStatus.pending:
      return EchnoColors.leaveStatusPending;
    case LeaveStatus.rejected:
      return EchnoColors.leaveStatusRejected;
    default:
      return EchnoColors.leaveStatusPending;
  }
}
