import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

Either<Failure, T> responseValidator<T>(Response<dynamic> response) {
  if (response.statusCode! >= 200 && response.statusCode! < 400) {
    return Right(response.data as T);
  } else {
    return Left(
      ServerFailure(response.data["message"], statusCode: response.statusCode),
    );
  }
}

Left<Failure, T> throwError<T>(e) {
  if (e is DioException) {
    DioException err = e;
    print("❌ ${err.response?.data["message"]}");
    return Left(
      ServerFailure(
        err.response?.data["message"] ?? "",
        statusCode: err.response?.statusCode,
      ),
    );
  }
  return Left(
    ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE, statusCode: 500),
  );
}
