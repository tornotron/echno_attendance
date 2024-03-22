/// A utility class for validating various types of data.
class EchnoValidator {
  /// Validates an email address.
  ///
  /// This method checks if the provided [value] is a valid email address.
  ///
  /// Parameters:
  ///   - value: The email address to validate.
  ///
  /// Returns:
  ///   - A string error message if the email is invalid, indicating the reason for failure.
  ///   - Returns null if the email is valid.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  /// Validates a password.
  ///
  /// This method checks if the provided [value] meets certain password requirements.
  ///
  /// Parameters:
  ///   - value: The password to validate.
  ///
  /// Returns:
  ///   - A string error message if the password is invalid, indicating the reason for failure.
  ///   - Returns null if the password is valid.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  /// Validates a phone number.
  ///
  /// This method checks if the provided [value] is a valid phone number.
  ///
  /// Parameters:
  ///   - value: The phone number to validate.
  ///
  /// Returns:
  ///   - A string error message if the phone number is invalid, indicating the reason for failure.
  ///   - Returns null if the phone number is valid.
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  /// Validates a field using a default validation logic.
  ///
  /// This method checks if the provided [value] is null or empty. If it is, it returns the [message] parameter
  /// which represents a custom error message. If no custom message is provided, it defaults to 'This field is required.'.
  /// If the [value] is not null or empty, it returns null, indicating that the validation passed.
  ///
  /// Parameters:
  ///   - value: The value to be validated.
  ///   - message: An optional custom error message to be returned if the validation fails. If not provided,
  ///     it defaults to 'This field is required.'.
  ///
  /// Returns:
  ///   - A string error message if the validation fails, indicating the reason for failure.
  ///   - Returns null if the validation passes.
  static String? defaultValidator<T>(T? value, [String? message]) {
    if (value == null || value.toString().isEmpty) {
      return message ?? 'This field is required.';
    }

    return null;
  }
}
