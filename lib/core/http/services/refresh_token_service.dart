import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class RefreshTokenService {
  late Dio client;
  RefreshTokenService({Dio? client}) {
    client = client ?? Dio();
    client.options = BaseOptions(baseUrl: "${API.BASE_URL}/auth/refresh-token");
    client.options.connectTimeout = Duration(seconds: 5);
    client.options.receiveTimeout = Duration(seconds: 3);
  }

  Future<Either<Failure, dynamic>> handle({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      final response = await client.post(
        "",
        data: {
          "grantType": "refresh_token",
          "accessToken": accessToken,
          "refreshToken": refreshToken,
        },
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }
}
