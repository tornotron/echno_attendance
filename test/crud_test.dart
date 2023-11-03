import 'dart:io';

import 'package:echno_attendance/attendance/utilities/crud_exceptions.dart';
import 'package:echno_attendance/crud/services/db_user_services.dart';
import 'package:echno_attendance/crud/utilities/crud_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  // Ensure that the Flutter binding is initialized for testing
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
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
      'open() should set the _isOpen flag to true and return without exception',
      () async {
    await mockDatabaseUserService.open();

    expect(mockDatabaseUserService._isOpen, isTrue);
  });

  // Test the createUser() method
  test('createUser() should create a new user and return it without exception',
      () async {
    // Create a new user object
    final user = DBUser(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: 1234567890,
      employeeID: '1234567890',
      employeeRole: 'Software Engineer',
      isActiveEmployee: true,
    );

    // Create the user
    await mockDatabaseUserService.createUser(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        employeeID: user.employeeID,
        employeeRole: user.employeeRole,
        isActiveEmployee: user.isActiveEmployee);

    // Check that the user was created successfully
    expect(mockDatabaseUserService._users.contains(user), isTrue);
  });

  // Test the deleteUser() method
  test('deleteUser() should delete the user and return without exception',
      () async {
    // Create a new user
    final user = DBUser(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: 1234567890,
      employeeID: '1234567890',
      employeeRole: 'Software Engineer',
      isActiveEmployee: true,
    );

    // Create the user
    await mockDatabaseUserService.createUser(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        employeeID: user.employeeID,
        employeeRole: user.employeeRole,
        isActiveEmployee: user.isActiveEmployee);

    // Delete the user
    await mockDatabaseUserService.deleteUser(employeeID: user.employeeID);

    // Check that the user was deleted successfully
    expect(mockDatabaseUserService._users.contains(user), isFalse);
  });

  // Test the getUser() method
  test(
      'getUser() should return the user if it exists and return without exception',
      () async {
    // Create a new user
    final user = DBUser(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: 1234567890,
      employeeID: '1234567890',
      employeeRole: 'Software Engineer',
      isActiveEmployee: true,
    );

// Create the user
    await mockDatabaseUserService.createUser(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        employeeID: user.employeeID,
        employeeRole: user.employeeRole,
        isActiveEmployee: user.isActiveEmployee);

// Get the user
    final retrievedUser =
        await mockDatabaseUserService.getUser(employeeID: user.employeeID);

// Check that the retrieved user is the same as the created user
    expect(retrievedUser, user);
  });

  // Test the updateUser() method
  test('updateUser() should update the user and return it without exception',
      () async {
    // Create a new user
    final user = DBUser(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: 1234567890,
      employeeID: '1234567890',
      employeeRole: 'Software Engineer',
      isActiveEmployee: true,
    );

    // Create the user
    await mockDatabaseUserService.createUser(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        employeeID: user.employeeID,
        employeeRole: user.employeeRole,
        isActiveEmployee: user.isActiveEmployee);

    // Update the user's employee role
    user.employeeRole = 'Site Engineer';

    // Update the user
    await mockDatabaseUserService.updateUser(
      user,
      user.employeeID,
      user.employeeRole,
      user.isActiveEmployee,
    );

    // Update the user
    await mockDatabaseUserService.updateUser(
        user, '1234567890', 'Manager', user.isActiveEmployee);

    // Get the updated user
    final updatedUser =
        await mockDatabaseUserService.getUser(employeeID: user.employeeID);

    // Check that the updated user has the new employee role
    expect(updatedUser.employeeRole, user.employeeRole);
  });

  // Test the close() method
  test(
      'close() should set the _isOpen flag to false and return without exception',
      () async {
    await mockDatabaseUserService.close();

    expect(mockDatabaseUserService._isOpen, isFalse);
  });
}

class DatabaseAlreadyOpenException implements Exception {}

class MockDatabaseUserService implements DatabaseUserService {
  // A flag to indicate whether the database is open
  bool _isOpen = false;

  // A list of users in the database
  final List<DBUser> _users = [];

  // A map of employee IDs to user objects
  final Map<String, DBUser> _employeeIDToUserMap = {};

  @override
  Future<void> open() async {
    if (_isOpen) throw DatabaseAlreadyOpenException();

    // Get the documents directory
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // Create the database file if it doesn't exist
    final databaseFile = File('${documentsDirectory.path}/echno_attendance.db');
    await databaseFile.create(recursive: true);

    _isOpen = true;
  }

  @override
  Future<DBUser> createUser({
    required int id,
    required String name,
    required String email,
    required int phoneNumber,
    required String employeeID,
    required String employeeRole,
    required bool isActiveEmployee,
  }) async {
    // Create a new user object
    final user = DBUser(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      employeeID: employeeID,
      employeeRole: employeeRole,
      isActiveEmployee: isActiveEmployee,
    );

    // Add the user to the map and the list
    _employeeIDToUserMap[employeeID] = user;
    _users.add(user);

    return user;
  }

  @override
  Future<DBUser> updateUser(
    DBUser user,
    String employeeID,
    String? employeeRole,
    bool? isActiveEmployee,
  ) async {
    user.employeeRole = employeeRole ?? user.employeeRole;
    // Find the user by employee ID
    final originalUser = _employeeIDToUserMap[employeeID];

    if (originalUser == null) {
      throw UserNotFoundException();
    }

    // Update the user details
    originalUser.employeeRole = employeeRole ?? originalUser.employeeRole;
    originalUser.isActiveEmployee =
        isActiveEmployee ?? originalUser.isActiveEmployee;

    // Update the user in the map
    _employeeIDToUserMap[employeeID] = originalUser;

    // Update the user in the list
    int userIndex = _users.indexWhere((u) => u.employeeID == employeeID);
    if (userIndex != -1) {
      _users[userIndex] = originalUser;
    }

    return originalUser;
  }

  @override
  Future<DBUser> getUser({required String employeeID}) async {
    if (!_isOpen) {
      throw DatabaseNotOpenException();
    }

    // Find the user by employee ID
    final user = _employeeIDToUserMap[employeeID];
    if (user == null) {
      throw CouldNotFindUser();
    }

    return user;
  }

  @override
  Future<void> deleteUser({required String employeeID}) async {
    if (!_isOpen) {
      throw DatabaseNotOpenException();
    }

    // Find the user by employee ID
    final user = _employeeIDToUserMap[employeeID];

    // If the user does not exist, throw an exception
    if (user == null) {
      throw CouldNotDeleteUser();
    }

    // Remove the user from the list of users
    _users.remove(user);

    // Remove the user from the map of employee IDs to user objects
    _employeeIDToUserMap.remove(employeeID);
    _users.removeWhere((user) => user.employeeID == employeeID);
  }

  @override
  Future<void> close() async {
    if (!_isOpen) {
      throw DatabaseNotOpenException();
    }

    _isOpen = false;
  }
}
