import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/auth/services/auth_service.dart';
import 'package:echno_attendance/auth/utilities/alert_dialogue.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/utilities/routes.dart';
import 'package:echno_attendance/utilities/show_error_dialog.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as devtools show log;

class EmployeeRegistrationWrapper {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> registerEmployee({
    required BuildContext context,
    required String employeeID,
    required String email,
    required String password,
  }) async {
    try {
      // Check if the employee exists
      DocumentSnapshot employeeSnapshot =
          await _userCollection.doc(employeeID).get();

      if (!employeeSnapshot.exists) {
        await showErrorDialog(context, 'Employee ID Not Found');
        return;
      }

      // Check employee details and registration status
      if (employeeSnapshot.get('email-id') == email &&
          employeeSnapshot.get('employee-status') == true) {
        await registerUser(context, employeeID, email, password);
      } else {
        await showErrorDialog(context, 'Invalid Employee Details');
      }
    } catch (e) {
      devtools.log('Error during employee registration: $e');
    }
  }

  Future<void> registerUser(
    BuildContext context,
    String employeeID,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await AuthService.firebase().createUser(
        email: email,
        password: password,
      );

      final currentUserUID = userCredential.uid;

      if (context.mounted) {
        Navigator.of(context).pushNamed(
          verifyEmailRoute,
        );
      }

      await AuthService.firebase().sendEmailVerification();
      await _userCollection.doc(employeeID).update({'uid': currentUserUID});
      verificationMailAltert(context);
      devtools.log('User Created Successfully! And Verification Mail Sent...');
    } on WeakPasswordAuthException {
      handleAuthError(context, 'Weak Password');
    } on EmailAlreadyInUseAuthException {
      handleAuthError(context, 'Email Already in Use');
    } on InvalidEmailAuthException {
      handleAuthError(context, 'Invalid Email');
    } on GenericAuthException catch (e) {
      handleAuthError(context, e.message);
    }
  }

  Future<void> handleAuthError(
      BuildContext context, String errorMessage) async {
    await showErrorDialog(context, errorMessage);
  }
}
