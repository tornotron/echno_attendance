import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'package:echno_attendance/leave_module/domain/firestore/firestore_leave_handler.dart';
import 'package:echno_attendance/leave_module/domain/firestore/leave_handler.dart';

class LeaveService implements LeaveHandler {
  final LeaveHandler _leaveHanler;
  const LeaveService(this._leaveHanler);

  factory LeaveService.firestoreLeave() {
    return LeaveService(FirestoreLeaveHandler());
  }

  @override
  Future<Leave?> applyForLeave({
    required String authUserId,
    required String employeeId,
    required String profilePhoto,
    required String employeeName,
    required DateTime appliedDate,
    required DateTime fromDate,
    required DateTime toDate,
    required String? leaveType,
    required String siteOffice,
    required String? remarks,
  }) {
    return _leaveHanler.applyForLeave(
      authUserId: authUserId,
      employeeId: employeeId,
      profilePhoto: profilePhoto,
      employeeName: employeeName,
      appliedDate: appliedDate,
      fromDate: fromDate,
      toDate: toDate,
      leaveType: leaveType,
      siteOffice: siteOffice,
      remarks: remarks,
    );
  }

  @override
  Future<void> cancelLeave({required String leaveId}) {
    return _leaveHanler.cancelLeave(leaveId: leaveId);
  }

  @override
  Stream<List<Leave>> fetchLeaves() {
    return _leaveHanler.fetchLeaves();
  }

  @override
  Stream<List<Leave>> streamLeaveHistory({required String? authUserId}) {
    return _leaveHanler.streamLeaveHistory(authUserId: authUserId);
  }

  @override
  Future<void> updateLeaveStatus({
    required String leaveId,
    required String newStatus,
  }) {
    return _leaveHanler.updateLeaveStatus(
      leaveId: leaveId,
      newStatus: newStatus,
    );
  }
}
