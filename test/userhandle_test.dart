import 'package:flutter_test/flutter_test.dart';
import 'package:echno_attendance/employee/domain/firestore/firestore_database_handler.dart';

void main() {
  group('FirestoreUserServices', () {
    late FirestoreDatabaseHandler firestoreUserServices;

    setUp(() {
      firestoreUserServices = FirestoreDatabaseHandler();
    });

    test('Create user should add a new user to Firestore', () async {
      const employeeId = 'testUserId';
      const name = 'Test User';
      const email = 'test@example.com';
      const phoneNumber = '1234567890';
      const userRole = 'Employee';
      const isActiveUser = true;

      await firestoreUserServices.createUser(
        employeeId: employeeId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser,
      );

      final userData =
          await firestoreUserServices.readUser(employeeId: employeeId);

      expect(userData['name'], equals(name));
      expect(userData['email'], equals(email));
      expect(userData['phoneNumber'], equals(phoneNumber));
      expect(userData['userRole'], equals(userRole));
      expect(userData['isActiveUser'], equals(isActiveUser));
    });

    test('Update user should modify user data in Firestore', () async {
      const employeeId = 'testUserId';
      const newName = 'Updated User Name';

      await firestoreUserServices.updateUser(
          employeeId: employeeId, name: newName);

      final updatedUserData =
          await firestoreUserServices.readUser(employeeId: employeeId);

      expect(updatedUserData['name'], equals(newName));
    });

    test('Delete user should remove user data from Firestore', () async {
      const employeeId = 'testUserId';

      await firestoreUserServices.deleteUser(employeeId: employeeId);

      final deletedUserData =
          await firestoreUserServices.readUser(employeeId: employeeId);

      expect(deletedUserData['name'], isNull);
      expect(deletedUserData['email'], isNull);
      expect(deletedUserData['phoneNumber'], isNull);
      expect(deletedUserData['userRole'], isNull);
      expect(deletedUserData['isActiveUser'], isNull);
    });
  });
}
