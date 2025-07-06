import 'dart:convert';

String stringEncoder(String value) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  return stringToBase64.encode(value);
}
