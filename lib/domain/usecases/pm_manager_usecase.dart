import 'package:echno_attendance/domain/usecases/user_reading.dart';

// ------------------INTERFACE-----------------------------

class InterfacePm {
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {}
}

//--------------------------CLASS-----------------------------------

class PmClass implements InterfacePm {
  @override
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {
    objUserReading.userProfileReading(name: nameStatus, email: emailStatus);
  }
}
