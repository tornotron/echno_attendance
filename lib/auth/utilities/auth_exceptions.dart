// Purpose: Login Exceptions

class UserNotFoundAuthException implements Exception {
  final String message = 'User not found';
}

class WrongPasswordAuthException implements Exception {
  final String message = 'Wrong password';
}

// Register Exceptions

class EmailAlreadyInUseAuthException implements Exception {
  final String message = 'Email already in use';
}

class WeakPasswordAuthException implements Exception {
  final String message = 'Weak password';
}

class InvalidEmailAuthException implements Exception {
  final String message = 'Invalid email';
}

// Purpose: General Exceptions

class GenericAuthException implements Exception {
  final String message;

  GenericAuthException(this.message);
}

class UserNotLoggedInAuthException implements Exception {
  final String message = 'User not logged in';
}

// Auth Related Firestore Exceptions
class NotAnEmployeeException implements Exception {
  final String message = 'Not an employee';
}
