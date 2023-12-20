abstract class LeaveProvider {
  Future<void> applyForLeave({
    required String uid,
    required String employeeID,
    required String employeeName,
    required String appliedDate,
    required String fromDate,
    required String toDate,
    required String? leaveType,
    required String remarks,
  });

  Stream<List<Map<String, dynamic>>> streamLeaveHistory({
    required String? uid,
  });

  Future<void> cancelLeave({required String leaveId});

  Stream<List<Map<String, dynamic>>> fetchLeaves();

  Future<void> updateLeaveStatus({
    required String leaveId,
    required String newStatus,
  });
}
