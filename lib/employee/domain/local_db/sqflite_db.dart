import 'dart:io';

import 'package:echno_attendance/employee/utilities/crud_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseUserService {
  Database? _database;

  @protected
  Database getDatabase() {
    final database = _database;
    if (database == null) {
      throw DatabaseNotOpen();
    } else {
      return database;
    }
  }

  Future<void> open() async {
    if (_database != null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final Directory docsPath = await getApplicationDocumentsDirectory();
      final String dbPath = join(docsPath.path, dbName);
      final Database database = await openDatabase(dbPath);
      _database = database;

      await database
          .execute(createEmployeeTable); // Database 'user' table creation
    } on MissingPlatformDirectoryException {
      throw Unabletogetdocumentsdirectory();
    }
  }

  Future<Database?> close() async {
    final database = _database;
    if (database == null) {
      throw DatabaseNotOpen();
    } else {
      await database.close();
      _database = null;
    }
    return _database;
  }

  Future<DbEmployee> createEmployee({
    required String employeeName,
    required String companyEmail,
    required int phoneNumber,
    required String employeeId,
    required String employeeRole,
    required bool employeeStatus,
  }) async {
    final database = getDatabase();
    final results = await database.query(
      employeeTable,
      limit: 1,
      where: '$companyEmailColumn = ?',
      whereArgs: [companyEmail.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final id = await database.insert(employeeTable, {
      companyEmailColumn: companyEmail.toLowerCase(),
      employeeNameColumn: employeeName,
      phoneNumberColumn: phoneNumber,
      employeeIdColumn: employeeId,
      employeeRoleColumn: employeeRole,
      employeeStatusColumn: employeeStatus ? 1 : 0,
    });

    return DbEmployee(
      id: id,
      employeeName: employeeName,
      companyEmail: companyEmail,
      phoneNumber: phoneNumber,
      employeeId: employeeId,
      employeeRole: employeeRole,
      employeeStatus: employeeStatus,
    );
  }

  Future<int> deleteEmployee({required String employeeID}) async {
    final database = getDatabase();
    final deleteStatus = await database.delete(
      employeeTable,
      where: '$employeeIdColumn = ?',
      whereArgs: [employeeID],
    );
    if (deleteStatus != 1) {
      throw CouldNotDeleteUser();
    }
    return deleteStatus;
  }

  Future<DbEmployee> getEmployee({required String employeeId}) async {
    final database = getDatabase();
    final results = await database.query(
      employeeTable,
      limit: 1,
      where: '$employeeIdColumn = ?',
      whereArgs: [employeeId],
    );
    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DbEmployee.fromRow(results.first);
    }
  }

  Future<DbEmployee> updateEmployee(
    DbEmployee dbUser,
    String employeeId,
    String? employeeName,
    String? companyEmail,
    String? employeeRole,
    bool? employeeStatus,
  ) async {
    final db = getDatabase();
    await getEmployee(employeeId: employeeId);

    final updatesCount = await db.update(employeeTable, {
      employeeIdColumn: employeeId,
      if (employeeName != null) employeeNameColumn: employeeName,
      if (companyEmail != null) companyEmailColumn: companyEmail.toLowerCase(),
      if (employeeRole != null) employeeRoleColumn: employeeRole,
      if (employeeStatus != null) employeeStatusColumn: employeeStatus ? 1 : 0,
    });
    if (updatesCount == 0) {
      throw CouldNotUpdateUser();
    } else {
      return await getEmployee(employeeId: employeeId);
    }
  }
}

class DbEmployee {
  int id;
  String employeeName;
  String companyEmail;
  int phoneNumber;
  String employeeId;
  String employeeRole;
  bool employeeStatus;

  DbEmployee({
    required this.id,
    required this.employeeName,
    required this.companyEmail,
    required this.phoneNumber,
    required this.employeeId,
    required this.employeeRole,
    required this.employeeStatus,
  });

  DbEmployee.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        employeeName = map[employeeNameColumn] as String,
        companyEmail = map[companyEmailColumn] as String,
        phoneNumber = map[phoneNumberColumn] as int,
        employeeId = map[employeeIdColumn] as String,
        employeeRole = map[employeeRoleColumn] as String,
        employeeStatus = (map[employeeStatusColumn] as int) == 1;

  @override
  String toString() =>
      'Employee, ID = $id, companyEmail = $companyEmail, employeeName = $employeeName, phoneNumber = $phoneNumber, employeeId = $employeeId, employeeRole = $employeeRole, employeeStatus = $employeeStatus,';

  @override
  bool operator ==(covariant DbEmployee other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Database 'user' table

const idColumn = 'id';
const companyEmailColumn = 'company_email';
const employeeIdColumn = 'employee_id';
const employeeNameColumn = 'employee_name';
const phoneNumberColumn = 'phone_number';
const employeeRoleColumn = 'employee_role';
const employeeStatusColumn = 'employee_status';

// General Database constants

const dbName = 'echno_attendance.db';
const employeeTable = 'employees';

// Database 'user' table creation

const createEmployeeTable = ''' CREATE TABLE IF NOT EXISTS $employeeTable (
              $idColumn INTEGER NOT NULL,
              $companyEmailColumn TEXT NOT NULL UNIQUE,
              $employeeNameColumn TEXT NOT NULL,
              $phoneNumberColumn NUMERIC NOT NULL UNIQUE,
              $employeeIdColumn TEXT NOT NULL UNIQUE,
              $employeeRoleColumn TEXT NOT NULL,
              $employeeStatusColumn INTEGER NOT NULL DEFAULT 1,
              PRIMARY KEY($idColumn AUTOINCREMENT),
              FOREIGN KEY($employeeRoleColumn) REFERENCES roles(role_name)
            );
            ''';
