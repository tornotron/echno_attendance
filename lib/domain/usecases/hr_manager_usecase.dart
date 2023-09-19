import 'package:echno_attendance/domain/usecases/user_creation.dart';
import 'package:echno_attendance/domain/usecases/user_deletion.dart';
import 'package:echno_attendance/domain/usecases/user_reading.dart';
import 'package:echno_attendance/domain/usecases/user_updation.dart';

// ------------------INTERFACE-----------------------------

class InterfaceHr {
  void createProfile(InterfaceUserCreation objUserCreation, String creationName,
      String creationEmail, String creationPassword) {}

  void updateProfile(InterfaceUserUpdation objUserUpdation,
      String? updationName, String? updationEmail) {}

  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {}

  void deleteProfile(InterfaceUserDeletion objUserDeletion) {}
}

//--------------------------CLASS-----------------------------------

class HrClass implements InterfaceHr {
  @override
  void createProfile(InterfaceUserCreation objUserCreation, String creationName,
      String creationEmail, String creationPassword) {
    objUserCreation.registerEmailPassword(
        name: creationName, email: creationEmail, password: creationPassword);
  }

  @override
  void updateProfile(InterfaceUserUpdation objUserUpdation,
      String? updationName, String? updationEmail) {
    objUserUpdation.userProfileUpdation(
        name: updationName, email: updationEmail);
  }

  @override
  void readProfile(InterfaceUserReading objUserReading, bool? nameStatus,
      bool? emailStatus) {
    objUserReading.userProfileReading(name: nameStatus, email: emailStatus);
  }

  @override
  void deleteProfile(InterfaceUserDeletion objUserDeletion) {
    objUserDeletion.userProfileDeletion();
  }
}
