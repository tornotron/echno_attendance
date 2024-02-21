import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum LeaveStatus {
  approved,
  pending,
  rejected,
  unclassified,
}

enum LeaveType {
  ml,
  al,
  cl,
  sl,
  pl,
  unclassified,
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
      return null;
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
      return null;
  }
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
  final String? remarks;

  const Leave({
    required this.id,
    required this.uid,
    required this.employeeID,
    required this.employeeName,
    required this.appliedDate,
    required this.fromDate,
    required this.toDate,
    this.leaveType,
    this.leaveStatus,
    required this.siteOffice,
    required this.isCancelled,
    this.remarks,
  });

  factory Leave.fromDocument(QueryDocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>;
      return Leave(
        id: doc.id,
        uid: data['user-uid'] ?? '',
        employeeID: data['employee-id'] ?? '',
        employeeName: data['employee-name'] ?? '',
        appliedDate: (data['applied-date'] as Timestamp).toDate(),
        fromDate: (data['from-date'] as Timestamp).toDate(),
        toDate: (data['to-date'] as Timestamp).toDate(),
        leaveType: data['leave-type'] != null
            ? getLeaveType(data['leave-type'])
            : LeaveType.unclassified,
        leaveStatus: data['leave-status'] != null
            ? getLeaveStatus(data['leave-status'])
            : LeaveStatus.unclassified,
        siteOffice: data['site-office'] ?? '',
        isCancelled: data['is-cancelled'] ?? false,
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
      ];
}
