import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserDeletion {
  Future userProfileDeletion() async {}
}

class EmUserDeletion implements InterfaceUserDeletion {
  @override
  Future userProfileDeletion() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    try {
      await user.delete();
    } catch (e) {
      print(e);
    }
  }
}
