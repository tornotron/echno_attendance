import 'package:echno_attendance/domain/usecases/user_reading.dart';

// ------------------INTERFACE-----------------------------

class InterfaceSe {
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {}
}

//--------------------------CLASS-----------------------------------

class SeClass implements InterfaceSe {
  @override
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {
    objUserReading.userProfileReading(name: nameStatus, email: emailStatus);
  }
}
