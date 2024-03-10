// LeaveType enum
enum LeaveType {
  ml,
  al,
  cl,
  sl,
  pl,
  unclassified,
}

// Returns the LeaveType based on the string value
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

// Returns the string value based on the LeaveType
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
