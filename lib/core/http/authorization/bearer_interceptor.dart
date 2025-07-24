import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/http/authorization/bearer_authorization_service.dart';
import 'package:tcc_le_app/core/http/domain/oauth_token.dart';

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
    OAuthToken? token = await authorizationService.getAccessToken();
    if (token != null && token.accessToken != null) {
      options.headers.addAll({'Authorization': "Bearer ${token.accessToken}"});
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      OAuthToken? token = await authorizationService.refreshAccessToken();
      if (token != null && token.accessToken != null) {
        err.requestOptions.headers['Authorization'] =
            "Bearer ${token.accessToken}";

        return handler.resolve(await dio.fetch(err.requestOptions));
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
