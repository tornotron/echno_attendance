import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtools show log;

import 'package:echno_attendance/leave_module/services/leave_provider.dart';

class FirestoreLeaveService implements LeaveProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String initialLeaveStatus = 'pending';

// Function for Leave Application
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
  }) async {
    try {
      await _firestore.collection('leaves').add({
        'uid': uid,
        'employee-id': employeeID,
        'employeeName': employeeName,
        'appliedDate': appliedDate,
        'fromDate': fromDate,
        'toDate': toDate,
        'leaveType': leaveType,
        'leaveStatus': initialLeaveStatus,
        'isCancelled': false,
        'remarks': remarks,
      });
      devtools.log('Leave application successful');
    } catch (e) {
      // Handle errors
      devtools.log('Error applying for leave: $e');
    }
  }

  // Search for an employee in DB by their firebase-uid
  @override
  Future<Map<String, dynamic>> searchEmployeeByUID(
      {required String uid}) async {
    try {
      // Search user with reference to the uid in firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        Map<String, dynamic> user =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        devtools.log('User found');
        return user;
      } else {
        devtools.log('User not found');
        return {}; // Return an empty map if no user is found
      }
    } catch (e) {
      devtools.log('Error searching for user: $e');
      return {}; // Return an empty map if an error occurs
    }
  }

  // Get this leave history of the currently logged in user
  @override
  Stream<List<Map<String, dynamic>>> streamLeaveHistory({
    required String? uid,
  }) {
    if (uid == null || uid.isEmpty) {
      // Retrun an empty stream if the uid is null or empty
      devtools.log('No User Logged In or User ID is Empty');
      return Stream.value([]);
    }

    return _firestore
        .collection('leaves')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map<List<Map<String, dynamic>>>(
      (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        return querySnapshot.docs.map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
            var leaveHistoryData = doc.data();
            leaveHistoryData['leave-id'] =
                doc.id; // Add the document ID to the map
            return leaveHistoryData;
          },
        ).toList();
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
        'isCancelled': true,
      });
    } catch (e) {
      devtools.log('Error cancelling leave: $e');
      rethrow;
    }
  }

  // Get the leave history of all employees
  @override
  Stream<List<Map<String, dynamic>>> fetchLeaves() {
    return _firestore.collection('leaves').snapshots().map(
      (QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        return querySnapshot.docs.map((doc) {
          var leaveData = doc.data();
          leaveData['leave-id'] = doc.id; // Add the document ID to the map
          return leaveData;
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
        'leaveStatus': newStatus,
      });
    } catch (e) {
      // Handle errors
      devtools.log('Error updating leave status: $e');
      rethrow;
    }
  }
}
