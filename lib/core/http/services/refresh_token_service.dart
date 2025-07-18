import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class RefreshTokenService {
  late HttpClient client;
  RefreshTokenService({Dio? dio}) {
    client = HttpClient("auth/refresh-token", dio: dio);
  }

  Future<Either<Failure, dynamic>> handle({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      return await client.post(
        "",
        data: {
          "grantType": "refresh_token",
          "accessToken": accessToken,
          "refreshToken": refreshToken,
        },
      );
    } catch (e) {
      return throwError(e);
    }
  }
}
