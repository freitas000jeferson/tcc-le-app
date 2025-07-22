import 'package:dartz/dartz.dart';
import 'package:tcc_le_app/core/domain/user_profile.dart';
import 'package:tcc_le_app/core/http/http_client_auth.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class GetProfileService {
  late HttpClientAuth client;
  GetProfileService() {
    client = HttpClientAuth("auth/profile");
  }
  Future<Either<Failure, UserProfile>> handle() async {
    try {
      var response = await client.find("");
      if (response.isLeft()) {
        return Left((response as Left).value);
      }
      return Right(UserProfile.fromJson((response as Right).value));
    } on ServerException {
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }
}
