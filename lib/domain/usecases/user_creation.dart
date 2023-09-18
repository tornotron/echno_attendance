import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserCreation {
  Future<User?> registerEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
        User? user;
        return user;
      }
}

class EmUserCreation implements InterfaceUserCreation {
  @override
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

// class HrUserCreation implements InterfaceUserCreation{

//   @override
//   void createUser(){}
// }

// class PmUserCreation implements InterfaceUserCreation{
//    @override
//   String createUser(){
//     return "Hello from pmusercreation_createuser";
//   }
// }

// class TcUserCreation implements InterfaceUserCreation{
//   @override
//   void createUser(){}
// }

// class SeUserCreation implements InterfaceUserCreation{
//   @override
//   void createUser(){}
// }

// class SpUserCreation implements InterfaceUserCreation{
//   @override
//   void createUser(){}
// }


