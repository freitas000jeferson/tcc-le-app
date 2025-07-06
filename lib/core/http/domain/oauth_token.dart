import 'package:dio/dio.dart';

typedef OAuthToken OAuthTokenExtractor(Response response);
typedef Future<bool> OAuthTokenValidator(OAuthToken token);

class OAuthToken {
  OAuthToken({
    this.tokenType,
    this.accessToken,
    this.refreshToken,
    this.expiration,
  });
  final String? tokenType;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiration;

  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration!);

  factory OAuthToken.fromMap(Map<String, dynamic> map) {
    dynamic expires = map['expiresIn'] ?? map['expires_in'] ?? map['expires'];
    int seconds = 30000;
    if (expires is String) {
      if (expires.contains("s")) {
        seconds = int.parse(expires.split("s")[0]) * 1;
      } else if (expires.contains("m")) {
        seconds = int.parse(expires.split("m")[0]) * 60;
      } else if (expires.contains("h")) {
        seconds = int.parse(expires.split("h")[0]) * 60 * 60;
      }
    } else if (expires is int) {
      seconds = expires * 1000;
    }
    return OAuthToken(
      tokenType: map['tokenType'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      expiration: DateTime.now().add(Duration(seconds: seconds)),
    );
  }

  Map<String, dynamic> toMap() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresIn': expiration?.millisecondsSinceEpoch,
  };
  @override
  String toString() {
    return 'OAuthToken{\naccessToken:${this.accessToken},\nrefreshToken:${this.refreshToken},\nexpiresIn:${this.expiration}';
  }
}
