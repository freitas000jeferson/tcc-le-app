import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class ResetPasswordService {
  late HttpClient client;
  ResetPasswordService({Dio? dio}) {
    client = HttpClient("auth/reset-password", dio: dio);
  }

  Future<Either<Failure, dynamic>> handle({
    required String email,
    required String code,
    required String password,
  }) async {
    try {
      return await client.post(
        "",
        data: {"email": email, "password": password, "code": code},
      );
    } catch (e) {
      return throwError(e);
    }
  }
}
