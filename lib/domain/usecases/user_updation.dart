import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserUpdation {
  Future userProfileUpdation(
      {required String name, required String email}) async {
    User? user;
    return user;
  }
}

class EmUserUpdation implements InterfaceUserUpdation {
  @override
  Future userProfileUpdation(
      {required String name, required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    try {
      await user.updateDisplayName(name);
      await user.updateEmail(email);
    } catch (e) {
      print(e);
    }
  }
}
