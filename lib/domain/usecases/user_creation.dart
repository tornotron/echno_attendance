import 'package:firebase_auth/firebase_auth.dart';

//----------------------Interface---------------------
class InterfaceUserCreation {
  Future<User?> registerEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    User? user;
    return user;
  }
}

//-----------------------mixin--------------------------
mixin registrationReuse {
  Future<User?> registerEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}

//--------------------------class----------------------------------

class EmUserCreation with registrationReuse implements InterfaceUserCreation {}

class HrUserCreation with registrationReuse implements InterfaceUserCreation {}

class PmUserCreation with registrationReuse implements InterfaceUserCreation {}

class TcUserCreation with registrationReuse implements InterfaceUserCreation {}

class SeUserCreation with registrationReuse implements InterfaceUserCreation {}

class SpUserCreation with registrationReuse implements InterfaceUserCreation {}
