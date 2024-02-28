import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'dart:developer' as devtools show log;

import 'package:echno_attendance/leave_module/services/leave_provider.dart';

class FirestoreLeaveProvider implements LeaveProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LeaveStatus initialLeaveStatus = LeaveStatus.pending;

  // Function for Leave Application

  @override
  Future<Leave> applyForLeave(
      {required String uid,
      required String employeeID,
      required String employeeName,
      required DateTime appliedDate,
      required DateTime fromDate,
      required DateTime toDate,
      required String? leaveType,
      required String siteOffice,
      required String? remarks}) async {
    final leave = await FirebaseFirestore.instance.collection('leaves').add({
      'user-uid': uid,
      'employee-id': employeeID,
      'employee-name': employeeName,
      'applied-date': appliedDate,
      'from-date': fromDate,
      'to-date': toDate,
      'leave-type': leaveType,
      'leave-status': initialLeaveStatus.toString().split('.').last,
      'site-office': siteOffice,
      'is-cancelled': false,
      'remarks': remarks,
    });
    devtools.log('Leave application successful');
    final fetchLeave = await leave.get();
    return Leave(
      id: fetchLeave.id,
      uid: uid,
      employeeID: employeeID,
      employeeName: employeeName,
      appliedDate: appliedDate,
      fromDate: fromDate,
      toDate: toDate,
      leaveType:
          leaveType != null ? getLeaveType(leaveType) : LeaveType.unclassified,
      leaveStatus: initialLeaveStatus,
      siteOffice: siteOffice,
      isCancelled: false,
      remarks: remarks ?? '',
    );
  }

  // @override
  // Future<Leave> applyForLeave({
  //   required String uid,
  //   required String employeeID,
  //   required String employeeName,
  //   required DateTime appliedDate,
  //   required DateTime fromDate,
  //   required DateTime toDate,
  //   required LeaveType? leaveType,
  //   required String siteOffice,
  //   required String? remarks,
  // }) async {
  //   try {
  //     await _firestore.collection('leaves').add({
  //       'uid': uid,
  //       'employee-id': employeeID,
  //       'employeeName': employeeName,
  //       'appliedDate': appliedDate,
  //       'fromDate': fromDate,
  //       'toDate': toDate,
  //       'leaveType': leaveType,
  //       'leaveStatus': initialLeaveStatus,
  //       'isCancelled': false,
  //       'remarks': remarks,
  //     });
  //     devtools.log('Leave application successful');
  //   } catch (e) {
  //     // Handle errors
  //     devtools.log('Error applying for leave: $e');
  //     rethrow;
  //   }
  // }

  // Get this leave history of the currently logged in user
  @override
  Stream<List<Leave>> streamLeaveHistory({
    required String? uid,
  }) {
    if (uid == null || uid.isEmpty) {
      // Retrun an empty stream if the uid is null or empty
      devtools.log('No User Logged In or User ID is Empty');
      return Stream.value([]);
    }

    return _firestore
        .collection('leaves')
        .where('user-uid', isEqualTo: uid)
        .snapshots()
        .map(
      (QuerySnapshot<Object?> querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Leave.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>);
        }).toList();
      },
    );
  }

  // Cancel a leave application
  @override
  Future<void> cancelLeave({required String leaveId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('leaves')
          .doc(leaveId)
          .update({
        'is-cancelled': true,
      });
    } catch (e) {
      devtools.log('Error cancelling leave: $e');
      rethrow;
    }
  }

  // Get the leave history of all employees
  @override
  Stream<List<Leave>> fetchLeaves() {
    return _firestore
        .collection('leaves')
        .where('is-cancelled',
            isEqualTo: false) // Filtering for cancelled leaves
        .snapshots()
        .map(
      (QuerySnapshot<Object?> querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Leave.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>);
        }).toList();
      },
    );
  }

  // Update the leave status of a leave application
  @override
  Future<void> updateLeaveStatus({
    required String leaveId,
    required String newStatus,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('leaves')
          .doc(leaveId)
          .update({
        'leave-status': newStatus,
      });
    } catch (e) {
      // Handle errors
      devtools.log('Error updating leave status: $e');
      rethrow;
    }
  }
}
