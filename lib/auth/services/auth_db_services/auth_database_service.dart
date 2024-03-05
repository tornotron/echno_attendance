import 'package:echno_attendance/auth/services/auth_db_services/auth_database_provider.dart';
import 'package:echno_attendance/auth/services/auth_db_services/firestore_auth_provider.dart';

class DatabaseService implements DatabaseHandler {
  final DatabaseHandler _provider;
  const DatabaseService(this._provider);

  factory DatabaseService.firestore() {
    return DatabaseService(FirestoreDatabaseHandler());
  }

  @override
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeID}) {
    return _provider.searchForEmployeeInDatabase(employeeID: employeeID);
  }

  @override
  Future<void> updateUserUIDToDatabase({
    required String employeeID,
    required String? uid,
  }) {
    return _provider.updateUserUIDToDatabase(
      employeeID: employeeID,
      uid: uid,
    );
  }
}
