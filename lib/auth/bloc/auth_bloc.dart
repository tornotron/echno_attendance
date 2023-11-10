import 'package:echno_attendance/auth/services/auth_provider.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthNotInitializedState()) {
    // Initial State of App
    on<AuthInitializeEvent>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;

      if (user == null) {
        emit(const AuthLoggedOutState(
          exception: null,
          isLoading: false,
        )); // user is not logged in
      } else if (!user.isemailVerified) {
        emit(
            const AuthEmailNotVerifiedState()); // user is logged in but not verified
      } else {
        emit(AuthLoggedInState(user)); // user is logged in and verified
      }
    });
    // User Login
    on<AuthLogInEvent>((event, emit) async {
      emit(const AuthLoggedOutState(
        exception: null,
        isLoading: true,
      )); // user login started
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isemailVerified) {
          emit(const AuthLoggedOutState(
            exception: null,
            isLoading: false,
          )); // user login completed but not verified
          emit(const AuthEmailNotVerifiedState());
        } else {
          emit(const AuthLoggedOutState(
            exception: null,
            isLoading: false,
          ));
          emit(AuthLoggedInState(user)); // user successfully logged in
        }
      } on Exception catch (e) {
        emit(AuthLoggedOutState(
          exception: e,
          isLoading: false,
        )); // user login failed or some error
      }
    });
    // User Logout
    on<AuthLogOutEvent>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthLoggedOutState(
          exception: null,
          isLoading: false,
        )); // user is logged out
      } on Exception catch (e) {
        emit(AuthLoggedOutState(
          exception: e,
          isLoading: false,
        )); // user logout failed or some error
      }
    });
  }
}
