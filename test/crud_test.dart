import 'package:echno_attendance/local_db/sqflite_db.dart';
import 'package:echno_attendance/employee/utilities/crud_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Database Service Tests', () {
    // Ensure that the Flutter binding is initialized for testing
    setUpAll(() async {
      // Initialize the FFI
      sqfliteFfiInit();
      // Change the default factory for unit testing calls for SQFlite
      databaseFactory = databaseFactoryFfi;

      TestWidgetsFlutterBinding.ensureInitialized();

      // Mock the path provider
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (MethodCall methodCall) async {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return '.';
          }
          return null;
        },
      );
    });

    // Create a mock database user service
    final mockDatabaseUserService = MockDatabaseUserService();

    // Test the open() method
    test(
        'throw DatabaseNotOpen exception if the open() method is not called before any other method',
        () async {
      expect(() => mockDatabaseUserService.getDatabase(),
          throwsA(const TypeMatcher<DatabaseNotOpen>()));
    });

    test(
        'open the Databae with open() method and check if Database is opened successfully',
        () async {
      await mockDatabaseUserService.open();
      expect(
          mockDatabaseUserService.getDatabase(), const TypeMatcher<Database>());
      await mockDatabaseUserService.close();
    });

    test('test create user and delete user from databsae', () async {
      await mockDatabaseUserService.open();
      // Create the user
      DbEmployee mockUser = await mockDatabaseUserService.createEmployee(
          employeeName: 'John Doe',
          companyEmail: 'john.doe@example.com',
          phoneNumber: 1234567890,
          employeeId: '1234567890',
          employeeRole: 'Software Engineer',
          employeeStatus: true);

      // Check that the user was created successfully
      expect(mockUser.companyEmail == 'john.doe@example.com', true);

      // Delete the user
      final success = await mockDatabaseUserService.deleteEmployee(
          employeeID: '1234567890');

      // Check that the user was deleted successfully
      expect(success, 1);
      await mockDatabaseUserService.close();
    });

//   // Test the getUser() method
    test(
        'test the get user method by creating a user and then retrieving it from the database',
        () async {
      await mockDatabaseUserService.open();
      // Create the user
      DbEmployee mockUser = await mockDatabaseUserService.createEmployee(
          employeeName: 'John Doe',
          companyEmail: 'john.doe@example.com',
          phoneNumber: 1234567890,
          employeeId: '1234567890',
          employeeRole: 'Software Engineer',
          employeeStatus: true);

// Get the user
      final DbEmployee retrievedUser =
          await mockDatabaseUserService.getEmployee(employeeId: '1234567890');

// Delete the user
      await mockDatabaseUserService.deleteEmployee(employeeID: '1234567890');

// Check that the retrieved user is the same as the created user
      expect(retrievedUser.id, mockUser.id);
      await mockDatabaseUserService.close();
    });

    // Test the updateUser() method
    test('test update user method by creating a user and then updating it',
        () async {
      await mockDatabaseUserService.open();
      // Create the user
      DbEmployee mockUser = await mockDatabaseUserService.createEmployee(
          employeeName: 'John Doe II',
          companyEmail: 'john.doe-2@example.com',
          phoneNumber: 2345678901,
          employeeId: '2345678901',
          employeeRole: 'Software Engineer',
          employeeStatus: true);

      // Update the user
      await mockDatabaseUserService.updateEmployee(
        mockUser,
        mockUser.employeeId,
        'Site Engineer',
      );

      // Get the updated user
      final updatedUser = await mockDatabaseUserService.getEmployee(
          employeeId: mockUser.employeeId);

// Delete the user
      await mockDatabaseUserService.deleteEmployee(
          employeeID: mockUser.employeeId);
      // Check that the updated user has the new employee role
      expect(updatedUser.employeeRole, 'Site Engineer');
      await mockDatabaseUserService.close();
    });

    // Test the close() method
    test(
        'test close method by closing the database and then checking if the database is closed',
        () async {
      await mockDatabaseUserService.open();
      final Database? db = await mockDatabaseUserService.close();

      expect(db, isNull);
    });
  });
}

class MockDatabaseUserService extends DatabaseUserService {
  // A fuction to check if database is open or not
  @override
  Database getDatabase() {
    return super.getDatabase();
  }
}
