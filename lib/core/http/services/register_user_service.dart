import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/dto/register_user_dto.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class RegisterUserService {
  late HttpClient client;
  RegisterUserService({Dio? dio}) {
    client = HttpClient("auth/register", dio: dio);
  }

  Future<Either<Failure, RegisterUserDtoResponse>> handle(
    RegisterUserDtoRequest data,
  ) async {
    try {
      var response = await client.post("", data: data.toJson());
      if (response.isLeft()) {
        return Left((response as Left).value);
      }

      return Right(RegisterUserDtoResponse.fromJson((response as Right).value));
    } on ServerException {
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }
}
