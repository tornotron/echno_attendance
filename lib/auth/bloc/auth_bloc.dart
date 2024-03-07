import 'package:echno_attendance/auth/domain/firebase/auth_handler.dart';
import 'package:echno_attendance/auth/bloc/auth_event.dart';
import 'package:echno_attendance/auth/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:echno_attendance/auth/services/database_services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthHandler authHandler)
      : super(const AuthNotInitializedState(isLoading: true)) {
    // Initial State of App
    on<AuthInitializeEvent>((event, emit) async {
      await authHandler.initialize();
      final user = authHandler.currentUser;
      final databaseService = DatabaseService.firestore();

      if (user == null) {
        emit(const AuthLoggedOutState(
          exception: null,
          isLoading: false,
        )); // user is not logged in
      } else if (!user.isEmailVerified) {
        emit(const AuthEmailNotVerifiedState(
            isLoading: false)); // user is logged in but not verified
      } else {
        emit(const AuthLoggedOutState(
          exception: null,
          isLoading: true,
          loadingMessage: 'Updating User...',
        ));
        try {
          AuthUser? authUser = await databaseService.searchForUserInDatabase(
              authUserId: user.uid);

          if (authUser == null) {
            databaseService.updateAuthUserToDatabase(authUser: user);
          }
          emit(AuthLoggedInState(
            user: user,
            isLoading: false,
          )); // user is logged in and verified
        } on Exception catch (e) {
          emit(AuthLoggedOutState(
            exception: e,
            isLoading: false,
          ));
        }
      }
    });
    // User Registration
    on<AuthRegistrationEvent>(
      (event, emit) async {
        final String email = event.email;
        final String password = event.password;
        final String? employeeId = event.emplyeeId;
        final databaseService = DatabaseService.firestore();
        try {
          final authUser = await authHandler.createUser(
            email: email,
            password: password,
          );
          emit(const AuthLoggedOutState(
            exception: null,
            isLoading: true,
            loadingMessage: 'Updating User...',
          ));
          try {
            AuthUser? newAuthUser = await databaseService
                .searchForUserInDatabase(authUserId: authUser.uid);

            if (newAuthUser == null) {
              databaseService.updateAuthUserToDatabase(
                  employeeId: employeeId, authUser: authUser);
            }
          } on Exception catch (e) {
            emit(AuthLoggedOutState(
              exception: e,
              isLoading: false,
            ));
          }
          await authHandler.sendEmailVerification();
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
      await authHandler.sendEmailVerification();
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
        final user = await authHandler.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
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
        await authHandler.resetPassword(toEmail: email);
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
        await authHandler.logOut();
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
