import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/http/utils/oauth_storage.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class LoginService {
  late HttpClient client;
  late OAuthStorage storage;
  LoginService({Dio? dio}) {
    client = HttpClient("auth/login", dio: dio);
    storage = OAuthDataStorage();
  }

  Future<Either<Failure, OAuthToken>> handle({
    required String username,
    required String password,
  }) async {
    try {
      var response = await client.post(
        "",
        data: {"username": username, "password": password},
      );
      if (response.isLeft()) {
        return Left((response as Left).value);
      }

      OAuthToken token = OAuthToken.fromMap((response as Right).value);
      await storage.save(token);
      print("#Response Token: ${token.toString()}");
      return Right(token);
    } on ServerException {
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }
}
