import 'package:echno_attendance/auth/services/auth_db_services/auth_database_provider.dart';
import 'package:echno_attendance/auth/services/auth_db_services/firestore_auth_provider.dart';

class AuthDatabaseService implements AuthDatabaseProvider {
  final AuthDatabaseProvider _provider;
  const AuthDatabaseService(this._provider);

  factory AuthDatabaseService.firestore() {
    return AuthDatabaseService(FirestoreAuthProvider());
  }

  @override
  Future<Map<String, dynamic>> searchForEmployeeInFirestore(
      {required String employeeID}) {
    return _provider.searchForEmployeeInFirestore(employeeID: employeeID);
  }

  @override
  Future<void> updateUserUIDToFirestore({
    required String employeeID,
    required String? uid,
  }) {
    return _provider.updateUserUIDToFirestore(
      employeeID: employeeID,
      uid: uid,
    );
  }
}
