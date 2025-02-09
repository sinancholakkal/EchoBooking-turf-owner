class Validation {
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    } else if (!value.endsWith("@gmail.com")) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  static String? passWordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    } else {
      return null;
    }
  }

  static String? conformPasswordValidation(
      {required String? value,
      required String? password,
      required String? conformPassword}) {
    if (value == null || value.isEmpty) {
      return "Conform password cannot be empty";
    } else if (password != conformPassword) {
      return "Passwords do not match.";
    } else {
      return null;
    }
  }

  static String? nameValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    } else {
      return null;
    }
  }

  static String? phoneNumberValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    } else if (value.length != 10) {
      return "Please enter valid number";
    } else {
      return null;
    }
  }

  static String? addressValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Address is required";
    } else {
      return null;
    }
  }

  static String? priceValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Price is required";
    } else {
      return null;
    }
  }

  static String? includeValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Include is required";
    } else {
      return null;
    }
  }

  static String? landMarkValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Landmark is required";
    } else {
      return null;
    }
  }
  static String? stateAndCountryValidate({required String? value}) {
    if (value == null || value.isEmpty) {
      return "Please use current location";
    } else {
      return null;
    }
  }
}
