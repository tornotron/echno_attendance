import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserDeletion {
  Future userProfileDeletion() async {}
}

mixin deletionReuse {
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

class EmUserDeletion with deletionReuse implements InterfaceUserDeletion {}

class HrUserDeletion with deletionReuse implements InterfaceUserDeletion {}

class PmUserDeletion with deletionReuse implements InterfaceUserDeletion {}

class TcUserDeletion with deletionReuse implements InterfaceUserDeletion {}

class SeUserDeletion with deletionReuse implements InterfaceUserDeletion {}

class SpUserDeletion with deletionReuse implements InterfaceUserDeletion {}
