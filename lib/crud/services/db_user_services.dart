import 'package:echno_attendance/crud/utilities/crud_exceptions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseUserService {
  Database? _database;

  Database _getDatabase() {
    final database = _database;
    if (database == null) {
      throw DatabaseNotOpen();
    } else {
      return database;
    }
  }

  Future<void> open() async {
    if (_database == null) {
      throw DatabaseAlreadyOpenException();
    }
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final database = await openDatabase(dbPath);
      _database = database;

      await database.execute(createUserTable); // Database 'user' table creation
    } on MissingPlatformDirectoryException {
      throw Unabletogetdocumentsdirectory();
    }
  }

  Future<void> close() async {
    final database = _database;
    if (database == null) {
      throw DatabaseNotOpen();
    } else {
      await database.close();
      _database = null;
    }
  }

  Future<DBUser> createUser({
    required int id,
    required String name,
    required String email,
    required int phoneNumber,
    required String employeeID,
    required String employeeRole,
    required bool isActiveEmployee,
  }) async {
    final database = _getDatabase();
    final results = await database.query(
      userTable,
      limit: 1,
      where: '$emailColumn = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final userId = await database.insert(userTable, {
      emailColumn: email.toLowerCase(),
      nameColumn: name,
      phoneNumberColumn: phoneNumber,
      employeeIdColumn: employeeID,
      employeeRoleColumn: employeeRole,
      isActiveEmployeeColumn: isActiveEmployee ? 1 : 0,
    });

    return DBUser(
      id: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      employeeID: employeeID,
      employeeRole: employeeRole,
      isActiveEmployee: isActiveEmployee,
    );
  }

  Future<void> deleteUser({required String email}) async {
    final database = _getDatabase();
    final deleteStatus = await database.delete(
      userTable,
      where: '$emailColumn = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deleteStatus != 1) {
      throw CouldNotDeleteUser();
    }
  }

  Future<DBUser> getUser({required String employeeID}) async {
    final database = _getDatabase();
    final results = await database.query(
      userTable,
      limit: 1,
      where: 'employeeId = ?',
      whereArgs: [employeeID],
    );
    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DBUser.fromRow(results.first);
    }
  }
}

class DBUser {
  final int id;
  final String name;
  final String email;
  final int phoneNumber;
  final String employeeID;
  final String employeeRole;
  final bool isActiveEmployee;

  const DBUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.employeeID,
    required this.employeeRole,
    required this.isActiveEmployee,
  });

  DBUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        email = map[emailColumn] as String,
        phoneNumber = map[phoneNumberColumn] as int,
        employeeID = map[employeeIdColumn] as String,
        employeeRole = map[employeeRoleColumn] as String,
        isActiveEmployee = (map[isActiveEmployeeColumn] as int) == 1;

  @override
  String toString() =>
      'Person, ID = $id, email = $email, name = $name, phoneNumber = $phoneNumber, employeeID = $employeeID, employeeRole = $employeeRole, isActiveEmployee = $isActiveEmployee,';

  @override
  bool operator ==(covariant DBUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Database 'user' table

const idColumn = 'id';
const emailColumn = 'email';
const employeeIdColumn = 'employeeId';
const nameColumn = 'name';
const phoneNumberColumn = 'phone_number';
const employeeRoleColumn = 'employee_role';
const isActiveEmployeeColumn = 'is_active_employee';

// General Database constants

const dbName = 'echno_attendance.db';
const userTable = 'user';

// Database 'user' table creation

const createUserTable = ''' CREATE TABLE IF NOT EXISTS "user" (
              "id"	INTEGER NOT NULL,
              "email"	TEXT NOT NULL UNIQUE,
              "name"	TEXT NOT NULL,
              "phone_number"	NUMERIC NOT NULL UNIQUE,
              "employee_id"	TEXT NOT NULL UNIQUE,
              "employee_role"	TEXT NOT NULL,
              "is_active_employee"	INTEGER NOT NULL DEFAULT 1,
              PRIMARY KEY("id" AUTOINCREMENT),
              FOREIGN KEY("employee_role") REFERENCES "roles"("role_name")
            );
            ''';
