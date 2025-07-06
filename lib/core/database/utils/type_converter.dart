class TypeConverter {
  static int booleanToJson(bool value) {
    return (value) ? 1 : 0;
  }

  static bool booleanFromJson(int value) {
    return value == 1;
  }

  static String dateToJson(DateTime value) {
    return value.toIso8601String();
  }

  static DateTime dateFromJson(String value) {
    return DateTime.parse(value);
  }
}
