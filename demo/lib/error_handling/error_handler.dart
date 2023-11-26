class ErrorHandler {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Return null for valid input (nullable string)
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can\'t be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null; // Return null for valid input (nullable string)
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number can\'t be empty';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null; // Return null for valid input (nullable string)
  }

  static String? validateCaptcha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Captcha can\'t be empty';
    }
    return null; // Return null for valid input (nullable string)
  }

  static String? validateRole(String? value) {
    if (value == null) {
      return 'Please select a role';
    }
    return null; // Return null for valid input (nullable string)
  }
}

