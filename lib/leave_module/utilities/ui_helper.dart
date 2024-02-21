import 'package:echno_attendance/constants/colors_string.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:flutter/material.dart';

// UI Helper Functions for LeaveStatusScreen
Icon getIcon(String leaveStatus, bool isCancelled) {
  if (isCancelled) {
    return const Icon(
      Icons.report_outlined,
      size: 60,
      color: leaveStatusOrangeColor,
    );
  }
  switch (leaveStatus) {
    case 'approved':
      return const Icon(
        Icons.check_circle_rounded,
        size: 60,
        color: echnoGreenColor,
      );
    case 'pending':
      return const Icon(
        Icons.hourglass_empty_rounded,
        size: 60,
        color: leaveStatusYellowColor,
      );
    case 'rejected':
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

Color getColor(String leaveStatus, bool isCancelled) {
  if (isCancelled) {
    return leaveStatusOrangeColor;
  }
  switch (leaveStatus) {
    case 'approved':
      return echnoGreenColor;
    case 'pending':
      return leaveStatusYellowColor;
    case 'rejected':
      return leaveStatusRedColor;
    default:
      return leaveStatusYellowColor;
  }
}

String getStatus(leaveStatus) {
  switch (leaveStatus) {
    case 'approved':
      return "Approved";

    case 'pending':
      return "Pending";

    case "rejected":
      return "Rejected";

    case 'unclassified':
      return "Pending";
    default:
      return "Pending";
  }
}

String getLeaveType(String leaveType) {
  switch (leaveType) {
    case 'Casual Leave':
      return "Casual Leave";
    case 'medicalLeave':
      return "Medical Leave";
    case 'Maternity Leave':
      return "Maternity Leave";
    case 'Annual Leave':
      return "Annual Leave";
    default:
      return "Leave";
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
      return 'Unclassified';
  }
}

LeaveType? getLeaveTypeFromString(String? type) {
  switch (type) {
    case 'Maternity Leave':
      return LeaveType.ml;
    case 'Annual Leave':
      return LeaveType.al;
    case 'Casual Leave':
      return LeaveType.cl;
    case 'Sick Leave':
      return LeaveType.sl;
    case 'Paternity Leave':
      return LeaveType.pl;
    case 'Unclassified':
      return LeaveType.unclassified;
    default:
      return null;
  }
}
