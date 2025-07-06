import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/domain/oauth_grant_type.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/http/utils/oauth_storage.dart';
import 'package:tcc_le_app/core/http/utils/string_utils.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

/// OAuth Client
class OAuth {
  String tokenUrl;
  String clientId;
  String clientSecret;
  Dio dio;
  OAuthStorage storage;
  OAuthTokenExtractor extractor;
  OAuthTokenValidator validator;

  OAuth({
    required this.tokenUrl,
    required this.clientId,
    required this.clientSecret,
    Dio? dio,
    OAuthStorage? storage,
    OAuthTokenExtractor? extractor,
    OAuthTokenValidator? validator,
  }) : this.dio = dio ?? Dio(),
       this.storage = storage ?? OAuthMemoryStorage(),
       this.extractor = extractor ?? ((res) => OAuthToken.fromMap(res.data)),
       this.validator =
           validator ?? ((token) => Future.value(!token.isExpired));

  Future<OAuthToken> requestTokenAndSave(OAuthGrantType grantType) async {
    return requestToken(grantType).then((token) => storage.save(token));
  }

  /// Request a new Access Token using a strategy
  Future<OAuthToken> requestToken(OAuthGrantType grantType) {
    final request = grantType.handle(
      RequestOptions(
        method: 'POST',
        path: '/',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          "Authorization": "Basic ${stringEncoder('$clientId:$clientSecret')}",
        },
      ),
    );

    return this.dio
        .request(
          tokenUrl,
          data: request.data,
          options: Options(
            contentType: request.contentType,
            headers: request.headers,
            method: request.method,
          ),
        )
        .then((res) => extractor(res));
  }

  /// return current access token or refresh
  Future<OAuthToken?> fetchOrRefreshAccessToken() async {
    OAuthToken? token = await this.storage.fetch();

    if (token?.accessToken == null) {
      throw OAuthException('missing_access_token', 'Missing access token!');
    }

    if (await this.validator(token!)) return token;

    return this.refreshAccessToken();
  }

  /// Refresh Access Token
  Future<OAuthToken> refreshAccessToken() async {
    OAuthToken? token = await this.storage.fetch();

    if (token?.refreshToken == null) {
      throw OAuthException('missing_refresh_token', 'Missing refresh token!');
    }

    return this.requestTokenAndSave(
      RefreshTokenGrant(refreshToken: token!.refreshToken!),
    );
  }
}
