import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:flutter/material.dart';

// UI Helper Functions for LeaveStatusScreen
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

LeaveStatus? getLeaveStatus(String? status) {
  switch (status) {
    case 'approved':
      return LeaveStatus.approved;
    case 'pending':
      return LeaveStatus.pending;
    case 'rejected':
      return LeaveStatus.rejected;
    case 'unclassified':
      return LeaveStatus.unclassified;
    default:
      throw Exception('Invalid leave status');
  }
}

String getLeaveStatusName(LeaveStatus? leaveStatus) {
  switch (leaveStatus) {
    case LeaveStatus.approved:
      return "Approved";

    case LeaveStatus.pending:
      return "Pending";

    case LeaveStatus.rejected:
      return "Rejected";

    case LeaveStatus.unclassified:
      return "Pending";
    default:
      throw Exception('Invalid leave status');
  }
}

LeaveType? getLeaveType(String? type) {
  switch (type) {
    case 'ml':
      return LeaveType.ml;
    case 'al':
      return LeaveType.al;
    case 'cl':
      return LeaveType.cl;
    case 'sl':
      return LeaveType.sl;
    case 'pl':
      return LeaveType.pl;
    case 'unclassified':
      return LeaveType.unclassified;
    default:
      throw Exception('Invalid leave type');
  }
}

String getLeaveTypeName(LeaveType? type) {
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
    default:
      throw Exception('Invalid leave type');
  }
}
