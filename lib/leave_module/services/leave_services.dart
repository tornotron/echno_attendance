import 'package:echno_attendance/leave_module/services/firestore_leave_provider.dart';
import 'package:echno_attendance/leave_module/services/leave_provider.dart';

class LeaveService implements LeaveProvider {
  final LeaveProvider _leaveProvider;
  const LeaveService(this._leaveProvider);

  factory LeaveService.firestoreLeave() {
    return LeaveService(FirestoreLeaveProvider());
  }

  @override
  Future<void> applyForLeave({
    required String uid,
    required String employeeID,
    required String employeeName,
    required String appliedDate,
    required String fromDate,
    required String toDate,
    required String? leaveType,
    required String remarks,
  }) {
    return _leaveProvider.applyForLeave(
      uid: uid,
      employeeID: employeeID,
      employeeName: employeeName,
      appliedDate: appliedDate,
      fromDate: fromDate,
      toDate: toDate,
      leaveType: leaveType,
      remarks: remarks,
    );
  }

  @override
  Future<void> cancelLeave({required String leaveId}) {
    return _leaveProvider.cancelLeave(leaveId: leaveId);
  }

  @override
  Stream<List<Map<String, dynamic>>> fetchLeaves() {
    return _leaveProvider.fetchLeaves();
  }

  @override
  Stream<List<Map<String, dynamic>>> streamLeaveHistory(
      {required String? uid}) {
    return _leaveProvider.streamLeaveHistory(uid: uid);
  }

  @override
  Future<void> updateLeaveStatus({
    required String leaveId,
    required String newStatus,
  }) {
    return _leaveProvider.updateLeaveStatus(
      leaveId: leaveId,
      newStatus: newStatus,
    );
  }
}
