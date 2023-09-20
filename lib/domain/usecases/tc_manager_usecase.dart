import 'package:echno_attendance/domain/usecases/user_reading.dart';

// ------------------INTERFACE-----------------------------

class InterfaceTc {
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {}
}

//--------------------------CLASS-----------------------------------

class TcClass implements InterfaceTc {
  @override
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {
    objUserReading.userProfileReading(name: nameStatus, email: emailStatus);
  }
}
