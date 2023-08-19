import 'package:echno_attendance/domain/usecases/user_creation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InterfaceHr {
  void createProfile(InterfaceUserCreation objUsercreation, String emName,
      String emEmail, String emPassword) {}

  // void updateProfile() {}

  // void readProfile() {}

  // void deleteProfile() {}
}

class HrClass implements InterfaceHr {
  @override
  void createProfile(InterfaceUserCreation objUsercreation, String emName,
      String emEmail, String emPassword) {
    Future<User?> empUser = objUsercreation.registerEmailPassword(
        name: emName, email: emEmail, password: emPassword);
  }

  // @override
  // void updateProfile() {}

  // @override
  // void readProfile() {}

  // @override
  // void deleteProfile() {}
}

void main()                                                                                                 //for testing
{
  final hrUserHandling = HrClass().createProfile(EmUserCreation(), "jacob", "jacob@gmail.com", "1234");
 

  // hrClassWithEmUserHandling.updateProfile();
  // hrClassWithEmUserHandling.readProfile();
  // hrClassWithEmUserHandling.deleteProfile();

  // final hrClassWithPmUserCreation = HrClass(PmUserCreation());
  // final hrClassWithTcUserCreation = HrClass(TcUserCreation());
}
