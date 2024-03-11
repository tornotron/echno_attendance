import 'package:echno_attendance/auth/utilities/auth_exceptions.dart';
import 'package:echno_attendance/auth/domain/firebase/auth_handler.dart';
import 'package:echno_attendance/auth/models/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication:', () {
    final provider = MockAuthProvider();

    test('should not be initialized', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () async {
      expect(() async => await provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });

    test('Should be able to initialize', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('createUser should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        authUserEmail: 'wrongemail@echno.com',
        password: 'password',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        authUserEmail: 'email@echno.com',
        password: 'wrongpassword',
      );

      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        authUserEmail: 'email@echo.com',
        password: 'password',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to logout and login again', () async {
      await provider.logOut();
      expect(provider.currentUser, null);
      final user = await provider.logIn(
        authUserEmail: 'email@echno.com',
        password: 'password',
      );
      expect(provider.currentUser, user);
    });
    test('Should allow logging in after resetting password', () async {
      await provider.initialize();

      // Create a user
      await provider.createUser(
        authUserEmail: 'existinguser@echno.com',
        password: 'oldpassword',
      );

      // Reset the password
      await provider.resetPassword(authUserEmail: 'existinguser@echotech.com');

      // Simulate the user receiving the reset email and setting a new password
      // This is where you would typically send an email to the user with a link to reset the password
      // For simplicity, we'll just update the password directly here
      await provider.updatePassword(
        email: 'existinguser@echno.com',
        newPassword: 'newpassword',
      );

      // Log in with the new password
      final user = await provider.logIn(
        authUserEmail: 'existinguser@echno.com',
        password: 'newpassword',
      );

      expect(provider.currentUser, user);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthHandler {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String authUserEmail,
    required String password,
  }) async {
    if (!_isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      authUserEmail: authUserEmail,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String authUserEmail,
    required String password,
  }) {
    if (!_isInitialized) throw NotInitializedException();
    if (authUserEmail == 'wrongemail@echno.com') {
      return throw UserNotFoundAuthException();
    }
    if (password == 'wrongpassword') {
      return throw WrongPasswordAuthException();
    }
    const user = AuthUser(
      isEmailVerified: false,
      authUserId: '',
      authUserEmail: '',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!_isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!_isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      authUserId: 'currentuseruid',
      authUserEmail: 'currentiseremail',
    );
    _user = newUser;
  }

  @override
  Future<void> resetPassword({required String authUserEmail}) async {
    if (!_isInitialized) throw NotInitializedException();
    if (_user != null) {
      // Simulate the reset email being sent successfully
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<void> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    // In a real application, you would typically update the password in your authentication system
    // Here, we'll just update the password in-memory for simplicity
    if (_user != null) {
      _user = const AuthUser(
        isEmailVerified: true,
        authUserId: 'currentuseruid',
        authUserEmail: 'currentuseremail',
      );
    }
  }
}
