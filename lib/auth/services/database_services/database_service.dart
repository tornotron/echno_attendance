import 'package:echno_attendance/auth/domain/firestore/database_handler.dart';
import 'package:echno_attendance/auth/domain/firestore/firestore_database_handler.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';

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
  Future<AuthUser?> searchForUserInDatabase({required String authUserId}) {
    return _handler.searchForUserInDatabase(authUserId: authUserId);
  }

  @override
  Future<void> updateAuthUserToDatabase({
    String? employeeId,
    required AuthUser authUser,
  }) {
    return _handler.updateAuthUserToDatabase(
      employeeId: employeeId,
      authUser: authUser,
    );
  }
}
