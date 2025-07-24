import 'package:dartz/dartz.dart';
import 'package:tcc_le_app/core/http/http_client_auth.dart';
import 'package:tcc_le_app/core/http/utils/oauth_storage.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class LogoutService {
  late HttpClientAuth client;
  late OAuthStorage storage;

  LogoutService() {
    client = HttpClientAuth("auth/logout");
    storage = OAuthDataStorage();
  }
  Future<Either<Failure, dynamic>> handle() async {
    try {
      var response = await client.post("");
      if (response.isLeft()) {
        return Left((response as Left).value);
      }
      var redirect = (response as Right).value;
      await storage.clear();
      return Right(redirect);
    } on ServerException {
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }
}
