import 'package:echno_attendance/auth/domain/firestore/database_handler.dart';
import 'package:echno_attendance/auth/domain/firestore/firestore_database_handler.dart';

class DatabaseService implements DatabaseHandler {
  final DatabaseHandler _handler;
  const DatabaseService(this._handler);

  factory DatabaseService.firestore() {
    return DatabaseService(FirestoreDatabaseHandler());
  }

  @override
  Future<Map<String, dynamic>> searchForEmployeeInDatabase(
      {required String employeeId}) {
    return _handler.searchForEmployeeInDatabase(employeeId: employeeId);
  }

  @override
  Future<void> updateUserUIDToDatabase({
    required String employeeId,
    required String? uid,
  }) {
    return _handler.updateUserUIDToDatabase(
      employeeId: employeeId,
      uid: uid,
    );
  }
}
