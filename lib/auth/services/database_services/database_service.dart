import 'package:echno_attendance/auth/domain/firestore/database_handler.dart';
import 'package:echno_attendance/auth/domain/firestore/firestore_database_handler.dart';

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
