import 'package:dartz/dartz.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/http/services/refresh_token_service.dart';
import 'package:tcc_le_app/core/http/utils/oauth_storage.dart';
import 'package:tcc_le_app/core/routes/route_paths.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class BearerAuthorizationService {
  late OAuthStorage storage;
  late RefreshTokenService refreshTokenService;

  BearerAuthorizationService()
    : refreshTokenService = RefreshTokenService(),
      storage = OAuthDataStorage();

  validateToken(token) {
    var payload = Jwt.parseJwt(token.accessToken!);

    return Future.value(
      DateTime.fromMillisecondsSinceEpoch(
        payload["exp"] * 1000,
      ).isAfter(DateTime.now()),
    );
  }

  Future<OAuthToken> saveToken(OAuthToken token) async {
    return await storage.save(token);
  }

  Future redirectToLogin() async {
    await Get.offAndToNamed(RoutePaths.LOGIN_PAGE);
  }

  Future<OAuthToken?> getAccessToken() async {
    OAuthToken? token = await storage.fetch();

    if (token?.accessToken == null) {
      // redirect to login
      await redirectToLogin();
      throw OAuthException('missing_access_token', 'Missing access token!');
    }
    if (await validateToken(token!)) return token;

    return refreshAccessToken();
  }

  Future<OAuthToken?> refreshAccessToken() async {
    OAuthToken? token = await storage.fetch();

    if (token == null || token.refreshToken == null) {
      // redirect to login
      await redirectToLogin();
      throw OAuthException('missing_refresh_token', 'Missing refresh token!');
    }
    Either<Failure, dynamic> response = await refreshTokenService.handle(
      accessToken: token.accessToken ?? '',
      refreshToken: token.refreshToken ?? '',
    );
    if (response.isLeft()) {
      // redirect to login
      await storage.clear();
      await redirectToLogin();
      throw OAuthException('missing_refresh_token', 'Missing refresh token!');
    }
    OAuthToken refresh = OAuthToken.fromMap((response as Right).value);
    return saveToken(refresh);
  }
}
