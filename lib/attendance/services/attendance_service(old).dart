// import 'dart:async';
// import 'package:echno_attendance/attendance/utilities/crud_exceptions.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart' show Database, openDatabase;
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart'
//     show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;

// const dbName = 'local.db';
// const attendanceTable = 'attendance';
// const userTable = 'user';
// const idColumn = 'id';
// const emailColumn = 'email';
// const userIdColumn = 'userId';
// const dateColumn = 'date';
// const isSyncedWithCloudColumn = 'is_synced_with_cloud';
// const createUserTableQuery = '''
//       CREATE TABLE IF NOT EXISTS $userTable (
//         $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
//         $emailColumn TEXT NOT NULL UNIQUE
//       ); ''';
// const createAttendanceTableQuery = '''
//       CREATE TABLE IF NOT EXISTS $attendanceTable (
//         $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
//         $userIdColumn INTEGER NOT NULL,
//         $dateColumn TEXT NOT NULL,
//         $isSyncedWithCloudColumn INTEGER NOT NULL DEFAULT 0,
//         FOREIGN KEY ($userIdColumn) REFERENCES $userTable ($idColumn)
//       ); ''';

// class AttendanceService {
//   Database? _db;

//   List<DatabaseAttendance> _attendance = [];

//   final _attendanceStreamController =
//       StreamController<List<DatabaseAttendance>>.broadcast();

//   Future<DatabaseUser> getOrCreateUser({required String email}) async {
//     try {
//       return await getUser(email: email);
//     } on UserNotFoundException {
//       return await createUser(email: email);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> _cacheAttendance(email) async {
//     final allAttendance = await getAttendance(email: email);
//     _attendance = allAttendance;
//     _attendanceStreamController.add(_attendance);
//   }

//   Future<void> open() async {
//     if (_db != null) throw DatabaseAlreadyOpenException();
//     try {
//       final docsPath = await getApplicationDocumentsDirectory();
//       final dbPath = join(docsPath.path, dbName);
//       final db = openDatabase(dbPath);
//       _db = await db;

//       await _db!.execute(createUserTableQuery);

//       await _db!.execute(createAttendanceTableQuery);
//     } on MissingPlatformDirectoryException {
//       throw UnabletoGetApplicationDocumentsDirectory();
//     }
//   }

//   Future<void> close() async {
//     if (_db == null) throw DatabaseNotOpenException();
//     await _db!.close();
//     _db = null;
//   }

//   Database _getDb() {
//     if (_db == null) throw DatabaseNotOpenException();
//     return _db!;
//   }

//   Future<void> deleteUser({required String email}) async {
//     final db = _getDb();
//     final deletedCount = await db.delete(
//       userTable,
//       where: '$emailColumn = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (deletedCount == 0) throw CouldNotDeleteUserException();
//   }

//   Future<DatabaseUser> createUser({required String email}) async {
//     final db = _getDb();
//     // Check if user already exist and throw and exception if it does
//     final existingUser = await db.query(
//       userTable,
//       where: '$emailColumn = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (existingUser.isNotEmpty) throw UserAlreadyExistException();
//     final id = await db.insert(
//       userTable,
//       {emailColumn: email.toLowerCase()},
//     );
//     return DatabaseUser(id: id, email: email.toLowerCase());
//   }

//   Future<DatabaseUser> getUser({required String email}) async {
//     final db = _getDb();
//     final user = await db.query(
//       userTable,
//       where: '$emailColumn = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (user.isEmpty) throw UserNotFoundException();
//     return DatabaseUser.fromRow(user.first);
//   }

//   Future<DatabaseAttendance> registerAttendance({
//     required String email,
//     required String date,
//   }) async {
//     final db = _getDb();
//     final user = await db.query(
//       userTable,
//       where: '$emailColumn = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (user.isEmpty) throw UserNotFoundException();
//     final userId = user.first[idColumn] as int;
//     final id = await db.insert(
//       attendanceTable,
//       {
//         userIdColumn: userId,
//         dateColumn: date,
//       },
//     );
//     return DatabaseAttendance(
//       id: id,
//       userId: userId,
//       date: date,
//       isSyncedWithCloud: false,
//     );
//   }

//   Future<List<DatabaseAttendance>> getAttendance(
//       {required String email}) async {
//     final db = _getDb();
//     final user = await db.query(
//       userTable,
//       where: '$emailColumn = ?',
//       whereArgs: [email.toLowerCase()],
//     );
//     if (user.isEmpty) throw UserNotFoundException();
//     final userId = user.first[idColumn] as int;
//     final attendance = await db.query(
//       attendanceTable,
//       where: '$userIdColumn = ?',
//       whereArgs: [userId],
//     );
//     return attendance.map((e) => DatabaseAttendance.fromRow(e)).toList();
//   }
// }

// @immutable
// class DatabaseUser {
//   final int id;
//   final String email;
//   const DatabaseUser({
//     required this.id,
//     required this.email,
//   });

//   DatabaseUser.fromRow(Map<String, Object?> map)
//       : id = map[idColumn] as int,
//         email = map[emailColumn] as String;

//   @override
//   String toString() => 'DatabaseUser(id: $id, email: $email)';
//   @override
//   bool operator ==(covariant DatabaseUser other) => id == other.id;

//   @override
//   int get hashCode => id.hashCode;
// }

// @immutable
// class DatabaseAttendance {
//   final int id;
//   final int userId;
//   final String date;
//   final bool isSyncedWithCloud;

//   const DatabaseAttendance({
//     required this.id,
//     required this.userId,
//     required this.date,
//     required this.isSyncedWithCloud,
//   });

//   DatabaseAttendance.fromRow(Map<String, Object?> map)
//       : id = map[idColumn] as int,
//         userId = map[userIdColumn] as int,
//         date = map[dateColumn] as String,
//         isSyncedWithCloud =
//             (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;

//   @override
//   String toString() =>
//       'DatabaseAttendance(id: $id, userId: $userId, date: $date, isSyncedWithCloud: $isSyncedWithCloud)';

//   @override
//   bool operator ==(covariant DatabaseAttendance other) => id == other.id;

//   @override
//   int get hashCode => id.hashCode;
// }
