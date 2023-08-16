import 'package:echno_attendance/domain/usecases/user_creation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InterfaceHr {
  void createProfile() {}

  // void updateProfile() {}

  // void readProfile() {}

  // void deleteProfile() {}
}

class HrClass implements InterfaceHr {
  IUserCreation objUsercreation;

  HrClass(this.objUsercreation);

  @override
  void createProfile() {
    Future<User?> empUser = objUsercreation.registerEmailPassword(
        name: "jacob", email: "jacob@gmail.com", password: "123456");

  }

  // @override
  // void updateProfile() {}

  // @override
  // void readProfile() {}

  // @override
  // void deleteProfile() {}
}

// void main()
// {
//   final hrClassWithEmUserCreation = HrClass(EmUserCreation());
//   final hrClassWithPmUserCreation = HrClass(PmUserCreation());
//   final hrClassWithTcUserCreation = HrClass(TcUserCreation());
// }
