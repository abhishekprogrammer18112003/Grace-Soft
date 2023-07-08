class Validators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is Required.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  static String? propertyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Property Name is required.';
    }
    return null;
  }
}
