import 'package:echno_attendance/services/auth/auth_exceptions.dart';
import 'package:echno_attendance/services/auth/auth_provider.dart';
import 'package:echno_attendance/services/auth/auth_user.dart';
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
        email: 'wrongemail@echno.com',
        password: 'password',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        email: 'email@echno.com',
        password: 'wrongpassword',
      );

      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        email: 'email@echo.com',
        password: 'password',
      );
      expect(provider.currentUser, user);
      expect(user.isemailVerified, false);
    });

    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isemailVerified, true);
    });

    test('Should be able to logout and login again', () async {
      await provider.logOut();
      expect(provider.currentUser, null);
      final user = await provider.logIn(
        email: 'email@echno.com',
        password: 'password',
      );
      expect(provider.currentUser, user);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
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
    required String email,
    required String password,
  }) {
    if (!_isInitialized) throw NotInitializedException();
    if (email == 'wrongemail@echno.com') {
      return throw UserNotFoundAuthException();
    }
    if (password == 'wrongpassword') {
      return throw WrongPasswordAuthException();
    }
    const user = AuthUser(isemailVerified: false);
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
    const newUser = AuthUser(isemailVerified: true);
    _user = newUser;
  }
}
