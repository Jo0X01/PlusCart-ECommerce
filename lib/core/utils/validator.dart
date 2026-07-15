const String emailRegexString =
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
const String passwordRegexString = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@]{6,}$';
const String urlRegexString = r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}(\/.*)?$';

abstract class Validator {
  // ---------------------------------------------------------------------------
  // Special validators
  // ---------------------------------------------------------------------------

  static String? validateIgnoreEmpty(
    String? value,
    String? Function(String?) validateCallback,
  ) {
    if (value == null || value.trim().isEmpty) return null;
    return validateCallback(value);
  }

  static String? validateWifiPassword(String? password, String security) {
    if (security == 'None') return null;

    password = password?.trim() ?? '';

    if (password.isEmpty) {
      return 'Password is required.';
    }

    if (security == 'WEP') {
      final isValid =
          password.length == 5 ||
          password.length == 13 ||
          RegExp(r'^[0-9A-Fa-f]{10}$').hasMatch(password) ||
          RegExp(r'^[0-9A-Fa-f]{26}$').hasMatch(password);

      return isValid ? null : 'Invalid WEP key.';
    }

    final is64Hex = RegExp(r'^[0-9A-Fa-f]{64}$').hasMatch(password);

    if ((password.length >= 8 && password.length <= 63) || is64Hex) {
      return null;
    }

    return 'Invalid WPA key.';
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'Please confirm your password.';
    }

    if (confirmPassword != password) {
      return 'Passwords do not match.';
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // General validators
  // ---------------------------------------------------------------------------

  static String? validateDate(DateTime? date) {
    if (date == null) {
      return 'Please select a date.';
    }
    return null;
  }

  static String? validateContent(String? value) {
    if ((value?.length ?? 0) > 500) {
      return 'Message cannot exceed 500 characters.';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required.';
    }

    if (!RegExp(urlRegexString).hasMatch(value.trim())) {
      return 'Please enter a valid URL.';
    }

    return null;
  }

  static String? validateLatitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Latitude is required.';
    }

    final latitude = double.tryParse(value.trim());

    if (latitude == null) {
      return 'Latitude must be a valid number.';
    }

    if (latitude < -90 || latitude > 90) {
      return 'Latitude must be between -90 and 90.';
    }

    return null;
  }

  static String? validateLongitude(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Longitude is required.';
    }

    final longitude = double.tryParse(value.trim());

    if (longitude == null) {
      return 'Longitude must be a valid number.';
    }

    if (longitude < -180 || longitude > 180) {
      return 'Longitude must be between -180 and 180.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    if (!RegExp(emailRegexString).hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required.';
    }

    if (!RegExp(passwordRegexString).hasMatch(value)) {
      return 'Password must be at least 6 characters long, contain one uppercase letter and one number.';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }

    final phone = value.trim().replaceAll(RegExp(r'[\s()-]'), '');

    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
      return 'Please enter a valid phone number.';
    }

    return null;
  }

  static String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Code is required.';
    }

    if (value.length < 6) {
      return 'Code must be at least 6 characters.';
    }

    return null;
  }
}
