import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';

/// Use to implement custom token storage
abstract class OAuthStorage {
  /// Read token
  Future<OAuthToken?> fetch();

  /// Save Token
  Future<OAuthToken> save(OAuthToken token);

  /// Clear token
  Future<void> clear();
}

/// Save Token in Memory
class OAuthMemoryStorage extends OAuthStorage {
  OAuthToken? _token;

  /// Read
  @override
  Future<OAuthToken?> fetch() async {
    return _token;
  }

  /// Save
  @override
  Future<OAuthToken> save(OAuthToken token) async {
    return _token = token;
  }

  /// Clear
  @override
  Future<void> clear() async {
    _token = null;
  }
}

class OAuthDataStorage extends OAuthStorage {
  final accessTokenKey = 'accessToken';
  final refreshTokenKey = 'refreshToken';

  final GetStorage _storage = GetStorage("token");

  @override
  Future<void> clear() async {
    await _storage.erase();
  }

  @override
  Future<OAuthToken?> fetch() async {
    var accessToken = await _storage.read(accessTokenKey);
    var refreshToken = await _storage.read(refreshTokenKey);

    if (accessToken == null ||
        accessToken == "" ||
        refreshToken == null ||
        refreshToken == "") {
      await clear();
      return null;
    }

    return OAuthToken(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiration: Jwt.getExpiryDate(accessToken),
    );
  }

  @override
  Future<OAuthToken> save(OAuthToken token) async {
    await _storage.write(accessTokenKey, token.accessToken);
    await _storage.write(refreshTokenKey, token.refreshToken);
    return token;
  }
}
