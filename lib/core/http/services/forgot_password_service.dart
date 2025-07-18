import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/http_client.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class ForgotPasswordService {
  late HttpClient client;
  ForgotPasswordService({Dio? dio}) {
    client = HttpClient("auth/forgot-password", dio: dio);
  }

  Future<Either<Failure, dynamic>> handle({required String email}) async {
    try {
      return await client.post("", data: {"email": email});
    } catch (e) {
      return throwError(e);
    }
  }
}
