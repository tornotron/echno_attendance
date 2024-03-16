import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:echno_attendance/employee/services/employee_service.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class SiteOffice {
  final logs = logger(SiteOffice, Level.info);
  final String siteOfficeName;
  final String status;
  final double longitude;
  final double latitude;
  List<Employee> membersList;

  SiteOffice({
    required this.siteOfficeName,
    required this.status,
    required this.longitude,
    required this.latitude,
    required this.membersList,
  });

  Future<void> populateMemberlist() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('site')
          .doc(siteOfficeName)
          .get();
      List<dynamic> empidList = documentSnapshot['employee-list'];

      for (String emp in empidList) {
        final empService = EmployeeService.firestore();
        Employee? employee = await empService.readEmployee(employeeId: emp);
        if (employee != null) {
          membersList.add(employee);
        }
      }
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception: ${error.message}');
    } catch (e) {
      logs.e('Other Exception: $e');
    }
  }
}
