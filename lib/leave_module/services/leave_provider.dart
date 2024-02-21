import 'package:echno_attendance/leave_module/models/leave_model.dart';

abstract class LeaveProvider {
  Future<Leave> applyForLeave({
    required String uid,
    required String employeeID,
    required String employeeName,
    required DateTime appliedDate,
    required DateTime fromDate,
    required DateTime toDate,
    required String? leaveType,
    required String siteOffice,
    required String? remarks,
  });

  Stream<List<Leave>> streamLeaveHistory({
    required String? uid,
  });

  Future<void> cancelLeave({required String leaveId});

  Stream<List<Map<String, dynamic>>> fetchLeaves();

  Future<void> updateLeaveStatus({
    required String leaveId,
    required String newStatus,
  });
}
