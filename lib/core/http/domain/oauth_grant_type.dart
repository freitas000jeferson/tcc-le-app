import 'package:dio/dio.dart';

/// Use to implement a custom grantType
abstract class OAuthGrantType {
  RequestOptions handle(RequestOptions request);
}

/// Obtain an access token using a username and password
class PasswordGrant extends OAuthGrantType {
  final String username;
  final String password;
  final List<String> scope;

  PasswordGrant({
    this.username = '',
    this.password = '',
    this.scope = const [],
  });

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data = {
      "grant_type": "password",
      "username": username,
      "password": password,
      "scope": scope.join(' '),
    };

    return request;
  }
}

/// Obtain an access token using an refresh token
class RefreshTokenGrant extends OAuthGrantType {
  String refreshToken;

  RefreshTokenGrant({required this.refreshToken});

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data = "grant_type=refresh_token&refresh_token=$refreshToken";
    return request;
  }
}
