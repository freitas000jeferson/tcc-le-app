class Validators {
  static final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  static bool isValidEmail(String email) => emailRegex.hasMatch(email);
  static bool isValidCode(String code) => RegExp(r"^[0-9]{6}$").hasMatch(code);
  static bool isValidLength(String value) => RegExp(r'^.{8,}$').hasMatch(value);
  static bool hasUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);
  static bool hasLowercase(String value) => RegExp(r'[a-z]').hasMatch(value);
  static bool hasNumber(String value) => RegExp(r'[0-9]').hasMatch(value);
  static bool hasSpecialChar(String value) =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=~`/\[\]\\]').hasMatch(value);
}
