import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/utilities/firebase_options.dart';
import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/auth/services/auth_services/auth_provider.dart';
import 'package:echno_attendance/auth/services/auth_services/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException(e.code);
      }
    } catch (e) {
      throw GenericAuthException(e.toString());
    }
  }

  @override
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException(e.code);
      }
    } catch (e) {
      throw GenericAuthException(e.toString());
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebaseUser(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> resetPassword({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebase_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenericAuthException(e.code);
      }
    } catch (e) {
      throw GenericAuthException(e.toString());
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<Map<String, dynamic>> searchForEmployeeInFirestore(
      {required String employeeID}) async {
    String? name, email, phoneNumber, userRole;
    bool? isActiveUser;
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeID).get();

      if (employeeDocument.exists) {
        Map<String, dynamic> employeeData =
            employeeDocument.data() as Map<String, dynamic>;
        name = employeeData['full-name'];
        email = employeeData['email-id'];
        phoneNumber = employeeData['phone'];
        userRole = employeeData['employee-role'];
        isActiveUser = employeeData['employee-status'];
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
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
      'isActiveUser': isActiveUser,
    };
  }

  @override
  Future<void> updateUserUIDToFirestore({
    required String employeeID,
    required String? uid,
  }) async {
    try {
      CollectionReference employeesCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot employeeDocument =
          await employeesCollection.doc(employeeID).get();

      if (employeeDocument.exists) {
        await employeesCollection.doc(employeeID).update({
          'uid': uid,
        });
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
