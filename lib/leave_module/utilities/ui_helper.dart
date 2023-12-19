import 'package:echno_attendance/constants/colors_string.dart';
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
