import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getAttendanceDatabasePath() async {
  const dbname = 'attendance_data.db';
  final directory = await getApplicationDocumentsDirectory();
  final dbpath = join(directory.path, dbname);
  return dbpath;
}
