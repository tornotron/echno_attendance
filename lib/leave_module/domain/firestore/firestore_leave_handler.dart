import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/leave_module/models/leave_model.dart';
import 'dart:developer' as devtools show log;

import 'package:echno_attendance/leave_module/domain/firestore/leave_handler.dart';
import 'package:echno_attendance/leave_module/utilities/leave_exceptions.dart';
import 'package:echno_attendance/leave_module/utilities/leave_status.dart';
import 'package:echno_attendance/leave_module/utilities/leave_type.dart';

class FirestoreLeaveHandler implements LeaveHandler {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LeaveStatus initialLeaveStatus = LeaveStatus.pending;

  // Function for Leave Application

  @override
  Future<Leave?> applyForLeave(
      {required String authUserId,
      required String employeeId,
      required String profilePhoto,
      required String employeeName,
      required DateTime appliedDate,
      required DateTime fromDate,
      required DateTime toDate,
      required String? leaveType,
      required String siteOffice,
      required String? remarks}) async {
    try {
      final leave = await FirebaseFirestore.instance.collection('leaves').add({
        'auth-user-uid': authUserId,
        'employee-id': employeeId,
        'profile-photo': profilePhoto,
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
        leaveId: fetchLeave.id,
        authUserId: authUserId,
        employeeId: employeeId,
        profilePhoto: profilePhoto,
        employeeName: employeeName,
        appliedDate: appliedDate,
        fromDate: fromDate,
        toDate: toDate,
        leaveType: leaveType != null
            ? getLeaveType(leaveType)
            : LeaveType.unclassified,
        leaveStatus: initialLeaveStatus,
        siteOffice: siteOffice,
        isCancelled: false,
        remarks: remarks ?? '',
      );
    } on FirebaseException catch (e) {
      if (e.code == 'cancelled') {
        throw OperationTerminateException;
      } else if (e.code == 'unauthenticated') {
        throw UnauthenticatedException;
      } else if (e.code == 'permission-denied') {
        throw UnauthorizedException;
      } else if (e.code == 'not-found') {
        throw NoDataFoundException;
      } else if (e.code == 'aborted') {
        throw OperationFailedException;
      } else {
        throw GenericLeaveException(e.code);
      }
    } catch (e) {
      throw GenericLeaveException(e.toString());
    }
  }

  // Get this leave history of the currently logged in user
  @override
  Stream<List<Leave>> streamLeaveHistory({
    required String? authUserId,
  }) {
    try {
      return _firestore
          .collection('leaves')
          .where('auth-user-uid', isEqualTo: authUserId)
          .snapshots()
          .map(
        (QuerySnapshot<Object?> querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return Leave.fromFirestore(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>);
          }).toList();
        },
      );
    } on FirebaseException catch (e) {
      if (e.code == 'cancelled') {
        throw OperationTerminateException;
      } else if (e.code == 'unauthenticated') {
        throw UnauthenticatedException;
      } else if (e.code == 'permission-denied') {
        throw UnauthorizedException;
      } else if (e.code == 'not-found') {
        throw NoDataFoundException;
      } else if (e.code == 'aborted') {
        throw OperationFailedException;
      } else {
        throw GenericLeaveException(e.code);
      }
    } catch (e) {
      throw GenericLeaveException(e.toString());
    }
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
    } on FirebaseException catch (e) {
      if (e.code == 'cancelled') {
        throw OperationTerminateException;
      } else if (e.code == 'unauthenticated') {
        throw UnauthenticatedException;
      } else if (e.code == 'permission-denied') {
        throw UnauthorizedException;
      } else if (e.code == 'not-found') {
        throw NoDataFoundException;
      } else if (e.code == 'aborted') {
        throw OperationFailedException;
      } else {
        throw GenericLeaveException(e.code);
      }
    } catch (e) {
      throw GenericLeaveException(e.toString());
    }
  }

  // Get the leave history of all employees
  @override
  Stream<List<Leave>> fetchLeaves() {
    try {
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
    } on FirebaseException catch (e) {
      if (e.code == 'cancelled') {
        throw OperationTerminateException;
      } else if (e.code == 'unauthenticated') {
        throw UnauthenticatedException;
      } else if (e.code == 'permission-denied') {
        throw UnauthorizedException;
      } else if (e.code == 'not-found') {
        throw NoDataFoundException;
      } else if (e.code == 'aborted') {
        throw OperationFailedException;
      } else {
        throw GenericLeaveException(e.code);
      }
    } catch (e) {
      throw GenericLeaveException(e.toString());
    }
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
    } on FirebaseException catch (e) {
      if (e.code == 'cancelled') {
        throw OperationTerminateException;
      } else if (e.code == 'unauthenticated') {
        throw UnauthenticatedException;
      } else if (e.code == 'permission-denied') {
        throw UnauthorizedException;
      } else if (e.code == 'not-found') {
        throw NoDataFoundException;
      } else if (e.code == 'aborted') {
        throw OperationFailedException;
      } else {
        throw GenericLeaveException(e.code);
      }
    } catch (e) {
      throw GenericLeaveException(e.toString());
    }
  }
}
