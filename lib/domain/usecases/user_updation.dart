import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserUpdation {
  Future userProfileUpdation({String? name, String? email}) async {}
}

mixin updationReuse {
  Future userProfileUpdation({String? name, String? email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    try {
      if (name != null) {
        await user.updateDisplayName(name);
      }
      if (email != null) {
        await user.updateEmail(email);
      }

      if (name == null && email == null) {
        // Code for the case when both name and email are null
      } else {
        if (name == null) {
          // Code for the case when only name is null
        }

        if (email == null) {
          // Code for the case when only email is null
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

class EmUserUpdation with updationReuse implements InterfaceUserUpdation {}

class HrUserUpdation with updationReuse implements InterfaceUserUpdation {}

class PmUserUpdation with updationReuse implements InterfaceUserUpdation {}

class TcUserUpdation with updationReuse implements InterfaceUserUpdation {}

class SeUserUpdation with updationReuse implements InterfaceUserUpdation {}

class SpUserUpdation with updationReuse implements InterfaceUserUpdation {}
