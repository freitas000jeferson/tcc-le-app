import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class BearerInterceptor implements Interceptor {
  final BearerAuthorizationService authorizationService;
  final Dio dio;
  BearerInterceptor({Dio? dio})
    : authorizationService = BearerAuthorizationService(),
      dio = dio ?? Dio();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Either<Failure, OAuthToken> response =
        await authorizationService.getAccessToken();
    if (response.isRight()) {
      OAuthToken token = (response as Right).value;
      if (token.accessToken != null) {
        options.headers.addAll({
          'Authorization': "Bearer ${token.accessToken}",
        });
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      Either<Failure, OAuthToken> response =
          await authorizationService.refreshAccessToken();
      if (response.isRight()) {
        OAuthToken token = (response as Right).value;
        if (token.accessToken != null) {
          err.requestOptions.headers['Authorization'] =
              "Bearer ${token.accessToken}";

          return handler.resolve(await dio.fetch(err.requestOptions));
        }
      }
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print("[:: RESPONSE ::] status: ${response.statusCode}");
    print(response.data);
    print("---------------");
    handler.next(response);
  }
}
