import 'package:echno_attendance/auth/services/auth_services/auth_provider.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthNotInitializedState(isLoading: true)) {
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
        emit(const AuthEmailNotVerifiedState(
            isLoading: false)); // user is logged in but not verified
      } else {
        emit(AuthLoggedInState(
          user: user,
          isLoading: false,
        )); // user is logged in and verified
      }
    });
    // User Registration
    on<AuthRegistrationEvent>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(
            email: email,
            password: password,
          );
          await provider.sendEmailVerification();
          emit(const AuthEmailNotVerifiedState(
              isLoading: false)); // user registration completed
        } on Exception catch (e) {
          emit(AuthRegistrationState(
            exception: e,
            isLoading: false,
          )); // user registration failed
        }
      },
    );
    // Email Verification
    on<AuthVerifyEmailEvent>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    // User Login
    on<AuthLogInEvent>((event, emit) async {
      emit(const AuthLoggedOutState(
          exception: null,
          isLoading: true,
          loadingMessage: 'Logging In...')); // user login started
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
          emit(const AuthEmailNotVerifiedState(isLoading: false));
        } else {
          emit(const AuthLoggedOutState(
            exception: null,
            isLoading: false,
          ));
          emit(AuthLoggedInState(
            user: user,
            isLoading: false,
          )); // user successfully logged in
        }
      } on Exception catch (e) {
        emit(AuthLoggedOutState(
          exception: e,
          isLoading: false,
        )); // user login failed or some error
      }
    });
    // Forgot Password
    on<AuthForgotPasswordEvent>((event, emit) async {
      // Navigate User to Forgot Password Screen
      emit(const AuthForgotPasswordState(
        exception: null,
        hasSentEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      if (email == null) {
        return;
      }
      // User Request for Password Reset
      emit(const AuthForgotPasswordState(
        exception: null,
        hasSentEmail: false,
        isLoading: true,
      ));

      bool didSendEmail;
      Exception? exception;
      try {
        await provider.resetPassword(toEmail: email);
        exception = null;
        didSendEmail = true;
      } on Exception catch (e) {
        exception = e;
        didSendEmail = false;
      }

      emit(AuthForgotPasswordState(
        exception: exception,
        hasSentEmail: didSendEmail,
        isLoading: false,
      ));
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
    // Navigate to Registration Screen from Login Screen
    on<AuthNeedToRegisterEvent>((event, emit) async {
      emit(const AuthRegistrationState(
        exception: null,
        isLoading: false,
      ));
    });
    // Navigate to Phone Login Screen
    on<AuthPhoneLogInInitiatedEvent>(
      (event, emit) {
        emit(const AuthPhoneLogInInitiatedState(isLoading: false));
      },
    );
  }
}
