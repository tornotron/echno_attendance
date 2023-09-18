import 'package:echno_attendance/domain/usecases/user_creation.dart';
import 'package:echno_attendance/domain/usecases/user_updation.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ------------------INTERFACE-----------------------------

class InterfaceHr {
  void createProfile(InterfaceUserCreation objUserCreation, String creationName,
      String creationEmail, String creationPassword) {}

  void updateProfile(InterfaceUserUpdation objUserUpdation, String updationName,
      String updationEmail) {}

  // void readProfile() {}

  // void deleteProfile() {}
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
  void updateProfile(InterfaceUserUpdation objUserUpdation, String updationName,
      String updationEmail) {
    objUserUpdation.userProfileUpdation(
        name: updationName, email: updationEmail);
  }

  // @override
  // void readProfile() {}

  // @override
  // void deleteProfile() {}
}

void main() //for testing
{
  final hruser = HrClass().updateProfile(EmUserUpdation(), "HELLP", "huh");

  // hrClassWithEmUserHandling.updateProfile();
  // hrClassWithEmUserHandling.readProfile();
  // hrClassWithEmUserHandling.deleteProfile();

  // final hrClassWithPmUserCreation = HrClass(PmUserCreation());
  // final hrClassWithTcUserCreation = HrClass(TcUserCreation());
}
