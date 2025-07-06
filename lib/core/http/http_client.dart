// ignore: file_names
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/constants/api.dart';
import 'package:tcc_le_app/core/http/utils/string_utils.dart';
import 'package:tcc_le_app/core/http/utils/validate_response.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class HttpClient {
  final Dio client = Dio();
  HttpClient(String route) {
    client.options = BaseOptions(baseUrl: "${API.BASE_URL}/$route");
    client.options.connectTimeout = Duration(seconds: 5);
    client.options.receiveTimeout = Duration(seconds: 3);
    String clientId = API.CLIENT_ID;
    String clientSecret = API.CLIENT_SECRET;
    String basicToken = stringEncoder('$clientId:$clientSecret');
    client.options.headers.addAll({"Authorization": "Basic $basicToken"});
  }
  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }

  Future<Either<Failure, T>> find<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }

  Future<Either<Failure, T>> update<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }

  Future<Either<Failure, T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await client.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }

  Future<Either<Failure, dynamic>> uploadFile({
    String path = '',
    required File file,
    required String contentType,
  }) async {
    try {
      var arr = contentType.split("/");
      String fileName = "${arr[0]}.${arr[1]}";

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await client.post(path, data: data);

      return responseValidator(response);
    } catch (e) {
      return throwError(e);
    }
  }
}
