// Enum for LeaveStatus
enum LeaveStatus {
  approved,
  pending,
  rejected,
  unclassified,
}

// Returns the LeaveStatus based on the string value
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

// Returns the string value based on the LeaveStatus
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
