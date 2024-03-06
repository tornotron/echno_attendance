import 'package:echno_attendance/auth/models/auth_user.dart';

abstract class DatabaseHandler {
  Future<void> updateAuthUserToDatabase({
    String? employeeId,
    required AuthUser authUser,
  });

  Future<Map<String, dynamic>> searchForEmployeeInDatabase({
    required String employeeId,
  });

  Future<AuthUser?> searchForUserInDatabase({
    required String authUserId,
  });
}
