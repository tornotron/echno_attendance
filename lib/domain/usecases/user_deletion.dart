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

class EmUserUpdation with deletionReuse implements InterfaceUserDeletion {}

class HrUserUpdation with deletionReuse implements InterfaceUserDeletion {}

class PmUserUpdation with deletionReuse implements InterfaceUserDeletion {}

class TcUserUpdation with deletionReuse implements InterfaceUserDeletion {}

class SeUserUpdation with deletionReuse implements InterfaceUserDeletion {}

class SpUserUpdation with deletionReuse implements InterfaceUserDeletion {}
