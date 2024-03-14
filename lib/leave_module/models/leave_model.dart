import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';
import 'package:equatable/equatable.dart';

class Leave extends Equatable {
  final String leaveId;
  final String authUserId;
  final String employeeId;
  final String employeeName;
  final String profilePhoto;
  final DateTime appliedDate;
  final DateTime fromDate;
  final DateTime toDate;
  final LeaveType? leaveType;
  final LeaveStatus? leaveStatus;
  final String siteOffice;
  final bool isCancelled;
  final String? remarks;

  const Leave({
    required this.leaveId,
    required this.authUserId,
    required this.employeeId,
    required this.profilePhoto,
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

  factory Leave.fromFirestore(QueryDocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>;
      return Leave(
        leaveId: doc.id,
        authUserId: data['auth-user-uid'] ?? '',
        employeeId: data['employee-id'] ?? '',
        profilePhoto: data['profile-photo'] ?? '',
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

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      leaveId: json['id'] ?? '',
      authUserId: json['auth-user-id'] ?? '',
      employeeId: json['employee-id'] ?? '',
      profilePhoto: json['profile-photo'] ?? '',
      employeeName: json['employee-name'] ?? '',
      appliedDate: DateTime.parse(json['applied-date']),
      fromDate: DateTime.parse(json['from-date']),
      toDate: DateTime.parse(json['to-date']),
      leaveType: json['leave-type'] != null
          ? getLeaveType(json['leave-type'])
          : LeaveType.unclassified,
      leaveStatus: json['leave-status'] != null
          ? getLeaveStatus(json['leave-status'])
          : LeaveStatus.unclassified,
      siteOffice: json['site-office'] ?? '',
      isCancelled: json['is-cancelled'] ?? false,
      remarks: json['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': leaveId,
      'auth-user-id': authUserId,
      'employee-id': employeeId,
      'profile-photo': profilePhoto,
      'employee-name': employeeName,
      'applied-date': appliedDate.toIso8601String(),
      'from-date': fromDate.toIso8601String(),
      'to-date': toDate.toIso8601String(),
      'leave-type':
          leaveType != null ? leaveType!.toString().split('.').last : '',
      'leave-status':
          leaveStatus != null ? leaveStatus!.toString().split('.').last : '',
      'site-office': siteOffice,
      'is-cancelled': isCancelled,
      'remarks': remarks,
    };
  }

  @override
  List<Object?> get props => [
        authUserId,
        employeeId,
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
