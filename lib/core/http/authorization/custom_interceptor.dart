import 'package:dio/dio.dart';

class CustomInterceptor implements Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print("🚀 REQUEST");
    print(options.baseUrl);
    print(options.path);
    print(options.data);
    print("---------------");
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("🔴 ERROR ");
    print(err.message);
    print(err.response!.data);
    print(err.response!.statusCode);
    print("---------------");
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print("🟢 RESPONSE ");
    print(response.data);
    print(response.statusCode);
    print("---------------");
    handler.next(response);
  }
}
