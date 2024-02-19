import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum LeaveStatus {
  approved,
  pending,
  rejected,
  unclassified,
}

enum LeaveType {
  meternityLeave,
  annualLeave,
  casualLeave,
  sickLeave,
  peternityLeave,
  unclassified,
}

class Leave extends Equatable {
  final String id;
  final String uid;
  final String employeeID;
  final String employeeName;
  final DateTime appliedDate;
  final DateTime fromDate;
  final DateTime toDate;
  final LeaveType? leaveType;
  final LeaveStatus? leaveStatus;
  final String siteOffice;
  final bool isCancelled;
  final String remarks;

  const Leave({
    required this.id,
    required this.uid,
    required this.employeeID,
    required this.employeeName,
    required this.appliedDate,
    required this.fromDate,
    required this.toDate,
    required this.leaveType,
    required this.leaveStatus,
    required this.siteOffice,
    required this.isCancelled,
    required this.remarks,
  });

  factory Leave.fromDocument(QueryDocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>;
      return Leave(
        id: doc.id,
        uid: data['user_uid'] ?? '',
        employeeID: data['employee_id'] ?? '',
        employeeName: data['employee_name'] ?? '',
        appliedDate: data['applied_date'].toDate() ?? DateTime.now(),
        fromDate: data['from_date'].toDate() ?? DateTime.now(),
        toDate: data['to_date'].toDate() ?? DateTime.now(),
        leaveType: data['leave_type'] ?? LeaveType.unclassified,
        leaveStatus: data['leave_status'] ?? LeaveStatus.unclassified,
        siteOffice: data['site_office'] ?? '',
        isCancelled: data['is_cancelled'] ?? false,
        remarks: data['remarks'] ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [
        uid,
        employeeID,
        employeeName,
        appliedDate,
        fromDate,
        toDate,
        leaveType,
        leaveStatus,
        siteOffice,
        isCancelled,
        remarks,
      ];
}
