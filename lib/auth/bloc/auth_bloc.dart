import 'package:echno_attendance/auth/services/auth_provider.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthLoadingState()) {
    // Initial State of App
    on<AuthInitializeEvent>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;

      if (user == null) {
        emit(const AuthLoggedOutState(null)); // user is not logged in
      } else if (!user.isemailVerified) {
        emit(
            const AuthEmailNotVerifiedState()); // user is logged in but not verified
      } else {
        emit(AuthLoggedInState(user)); // user is logged in and verified
      }
    });
    // User Login
    on<AuthLogInEvent>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthLoggedInState(user));
      } on Exception catch (e) {
        emit(AuthLoggedOutState(e)); // user login failed or some error
      }
    });
    // User Logout
    on<AuthLogOutEvent>((event, emit) async {
      try {
        emit(const AuthLoadingState());
        await provider.logOut();
        emit(const AuthLoggedOutState(null)); // user is logged out
      } on Exception catch (e) {
        emit(AuthErrorState(e)); // user logout failed or some error
      }
    });
  }
}
