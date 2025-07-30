class TypeConverter {
  static int booleanToJson(bool value) {
    return (value) ? 1 : 0;
  }

  static bool booleanFromJson(int value) {
    return value == 1;
  }

  static String? dateToJson(DateTime? value) {
    return value?.toIso8601String();
  }

  static int? dateToInt(DateTime? value) {
    return value?.millisecondsSinceEpoch;
  }

  static DateTime dateFromInt(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }

  static DateTime? dateFromJson(String? value) {
    return value != null ? DateTime.parse(value) : null;
  }
}
