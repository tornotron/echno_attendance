import 'package:echno_attendance/phone_auth/services/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  String? _verificationId;

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: ((verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      }),
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        _verificationId = verificationId;
      }),
    );
  }

  void signInWithPhone(phoneAuthCredential) {}
}
