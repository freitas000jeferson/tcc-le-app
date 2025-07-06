import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class LoginService {
  late Dio client;
  LoginService({Dio? client}) {
    client = client ?? Dio();
    client.options = BaseOptions(baseUrl: "${API.BASE_URL}/auth/login");
    client.options.connectTimeout = Duration(seconds: 5);
    client.options.receiveTimeout = Duration(seconds: 3);
  }

  Future<Either<Failure, dynamic>> handle({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.post(
        "",
        data: {"username": username, "password": password},
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }
}
