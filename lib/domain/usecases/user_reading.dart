import 'package:firebase_auth/firebase_auth.dart';

class InterfaceUserReading {
  Future userProfileReading({bool? name, bool? email}) async {}
}

mixin readingReuse {
  Future userProfileReading({bool? name, bool? email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    try {
      if (name == true) {
        final getName = user.displayName;
      }
      if (email == true) {
        final getEmail = user.email;
      }

      if (name == null && email == null) {
        // Code for the case when both name and email are null
      } else {}
    } catch (e) {
      print(e);
    }
  }
}

class EmUserReading with readingReuse implements InterfaceUserReading {}

class HrUserReading with readingReuse implements InterfaceUserReading {}

class PmUserReading with readingReuse implements InterfaceUserReading {}

class TcUserReading with readingReuse implements InterfaceUserReading {}

class SeUserReading with readingReuse implements InterfaceUserReading {}

class SpUserReading with readingReuse implements InterfaceUserReading {}
