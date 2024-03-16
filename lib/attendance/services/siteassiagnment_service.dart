import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echno_attendance/logger.dart';
import 'package:logger/logger.dart';

class SiteAssignment {
  final logs = logger(SiteAssignment, Level.info);
  final List<String> employeeId;
  final String siteOfficeName;
  SiteAssignment({required this.employeeId, required this.siteOfficeName});

  Future<void> assignment() async {
    try {
      DocumentReference siteRef =
          FirebaseFirestore.instance.collection('site').doc(siteOfficeName);
      await siteRef.set({'employee-list': employeeId}, SetOptions(merge: true));
    } on FirebaseException catch (error) {
      logs.e('Firebase Exception : ${error.message}');
    } catch (e) {
      logs.e('Other Exception : $e');
    }
  }
}
