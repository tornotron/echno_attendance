import 'package:echno_attendance/domain/usecases/user_reading.dart';

// ------------------INTERFACE-----------------------------

class InterfaceSp {
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {}
}

//--------------------------CLASS-----------------------------------

class SpClass implements InterfaceSp {
  @override
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {
    objUserReading.userProfileReading(name: nameStatus, email: emailStatus);
  }
}
