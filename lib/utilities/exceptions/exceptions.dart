/// A class representing exceptions for handling various errors, especially related to Firebase authentication.
class EchnoExceptions implements Exception {
  /// The associated error message.
  ///
  /// This message provides information about the specific error that occurred.
  /// It can be customized to give detailed feedback to users about what went wrong.
  final String message;

  /// Constructs a new EchnoExceptions with an optional [message].
  ///
  /// If no [message] is provided, a generic error message is used by default.
  const EchnoExceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);

  /// Constructs a EchnoExceptions based on a Firebase authentication exception [code].
  ///
  /// This factory method translates Firebase authentication exception codes
  /// into meaningful error messages for better user understanding.
  ///
  /// If [code] is recognized, a specific error message corresponding to the code is used.
  /// If [code] is unrecognized, an [ArgumentError] is thrown.
  factory EchnoExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const EchnoExceptions(
            'The email address is already registered. Please use a different email.');
      case 'invalid-email':
        return const EchnoExceptions(
            'The email address provided is invalid. Please enter a valid email.');
      case 'weak-password':
        return const EchnoExceptions(
            'The password is too weak. Please choose a stronger password.');
      case 'user-disabled':
        return const EchnoExceptions(
            'This user account has been disabled. Please contact support for assistance.');
      case 'user-not-found':
        return const EchnoExceptions('Invalid login details. User not found.');
      case 'wrong-password':
        return const EchnoExceptions(
            'Incorrect password. Please check your password and try again.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const EchnoExceptions(
            'Invalid login credentials. Please double-check your information.');
      case 'too-many-requests':
        return const EchnoExceptions(
            'Too many requests. Please try again later.');
      case 'invalid-argument':
        return const EchnoExceptions(
            'Invalid argument provided to the authentication method.');
      case 'invalid-password':
        return const EchnoExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const EchnoExceptions('The provided phone number is invalid.');
      case 'operation-not-allowed':
        return const EchnoExceptions(
            'The sign-in provider is disabled for your Firebase project.');
      case 'session-cookie-expired':
        return const EchnoExceptions(
            'The Firebase session cookie has expired. Please sign in again.');
      case 'uid-already-exists':
        return const EchnoExceptions(
            'The provided user ID is already in use by another user.');
      case 'sign_in_failed':
        return const EchnoExceptions('Sign-in failed. Please try again.');
      case 'network-request-failed':
        return const EchnoExceptions(
            'Network request failed. Please check your internet connection.');
      case 'internal-error':
        return const EchnoExceptions('Internal error. Please try again later.');
      case 'invalid-verification-code':
        return const EchnoExceptions(
            'Invalid verification code. Please enter a valid code.');
      case 'invalid-verification-id':
        return const EchnoExceptions(
            'Invalid verification ID. Please request a new verification code.');
      case 'quota-exceeded':
        return const EchnoExceptions('Quota exceeded. Please try again later.');
      default:
        throw ArgumentError('Unhandled error code: $code');
    }
  }
}
