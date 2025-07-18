import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class LoginService {
  late HttpClient client;
  LoginService({Dio? dio}) {
    client = HttpClient("auth/login", dio: dio);
  }

  Future<Either<Failure, dynamic>> handle({
    required String username,
    required String password,
  }) async {
    try {
      return await client.post(
        "",
        data: {"username": username, "password": password},
      );
    } catch (e) {
      return throwError(e);
    }
  }
}
