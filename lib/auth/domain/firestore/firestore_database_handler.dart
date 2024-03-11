import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/auth/domain/firestore/database_handler.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';

class FirestoreDatabaseHandler implements DatabaseHandler {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeId}) async {
    String? employeeName;
    String? companyEmail;
    String? phoneNumber;
    String? employeeRole;
    bool? employeeStatus;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('employees');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeId).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;
        employeeName = employeeData['employee-name'];
        companyEmail = employeeData['company-email'];
        phoneNumber = employeeData['phone-number'];
        employeeRole = employeeData['employee-role'];
        employeeStatus = employeeData['employee-status'];
      }
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'not-found':
          throw NotAnEmployeeException();
        default:
          throw GenericAuthException('Firestore Exception: ${error.message}');
      }
    } catch (e) {
      throw GenericAuthException('Other Exception: $e');
    }
    return {
      'employee-name': employeeName,
      'company-email': companyEmail,
      'phone-number': phoneNumber,
      'employee-role': employeeRole,
      'employee-status': employeeStatus,
    };
  }

  @override
  Future<AuthUser?> searchForUserInDatabase(
      {required String authUserId}) async {
    final String authUserEmail;
    final bool isEmailVerified;
    AuthUser? authUser;

    try {
      CollectionReference userCollection = _firestore.collection('users');

      DocumentSnapshot userDocument =
          await userCollection.doc(authUserId).get();

      if (userDocument.exists) {
        Map<String, dynamic> authUserData =
            userDocument.data() as Map<String, dynamic>;
        authUserEmail = authUserData['auth-user-email'];
        isEmailVerified = authUserData['is-email-verified'];

        authUser = AuthUser(
          false,
          authUserId: authUserId,
          authUserEmail: authUserEmail,
          isEmailVerified: isEmailVerified,
        );
      }
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'not-found':
          throw NotAnEmployeeException();
        default:
          throw GenericAuthException('Firestore Exception: ${error.message}');
      }
    } catch (e) {
      throw GenericAuthException('Other Exception: $e');
    }
    return authUser;
  }

  @override
  Future<void> updateAuthUserToDatabase({
    String? employeeId,
    required AuthUser authUser,
  }) async {
    try {
      CollectionReference userCollection = _firestore.collection('users');

      await userCollection.doc(authUser.authUserId).set({
        'auth-user-id': authUser.authUserId,
        'auth-user-email': authUser.authUserEmail,
        'is-email-verified': authUser.isEmailVerified,
      });

      if (employeeId != null) {
        CollectionReference employeesCollection =
            _firestore.collection('employees');
        DocumentSnapshot employeeDocument =
            await employeesCollection.doc(employeeId).get();

        if (employeeDocument.exists) {
          await employeesCollection.doc(employeeId).update({
            'auth-user-id': authUser.authUserId,
            'auth-user-email': authUser.authUserEmail,
            'is-email-verified': authUser.isEmailVerified,
          });
        }
      }
    } on FirebaseException catch (error) {
      switch (error.code) {
        case 'not-found':
          throw NotAnEmployeeException();
        default:
          throw GenericAuthException('Firestore Exception: ${error.message}');
      }
    } catch (e) {
      throw GenericAuthException('Other Exception: $e');
    }
  }
}
