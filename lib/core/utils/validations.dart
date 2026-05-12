class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "required";
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  static String? validateField(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return "required";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "required";
    }

    // General international format: +8801712345678 or 01712345678
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Please enter a valid phone number";
    }

    return null;
  }
}
