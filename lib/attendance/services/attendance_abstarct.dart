abstract class AttendanceHandleProvider {
  Future<void> insertIntoDatabase(
      {required String employeeId,
      required String employeeName,
      required String attendanceDate,
      required String attendanceMonth,
      required String attendanceTime,
      required String attendanceStatus,
      required String siteName});
  Future<List<Map<String, String>>> fetchFromDatabase(
      {required String employeeId,
      required String attendanceMonth,
      required String attYear});
  Future<List<Map<String, String>>> fetchFromDatabaseDaily(
      {required String siteName, required String date});
}
