import 'package:equatable/equatable.dart';

class ServerException implements Exception {
  final String? message;

  ServerException({this.message});
}

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequiredFailure extends Failure {
  final String message;

  RequiredFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;

  ServerFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    // TODO: implement toString
    return "$message";
  }
}

class PermissionFailure extends Failure {
  final String message = "Error connecting to server";

  @override
  List<Object> get props => [message];
}

class FailuresMessages {
  // ignore: non_constant_identifier_names
  static final String SERVER_CONNECTION_FAILURE = "Error connecting to server";

  // ignore: non_constant_identifier_names
  static Map<int, dynamic> HTTP_FAILUES = {
    400: "Request Error",
    401: "Unauthorized Error",
    403: "Forbidden Error",
    404: "Not Found Error",
    408: "Time Out Error",
    500: "Server internal Error",
  };
}

class OAuthFailure extends Failure {
  final String code;
  final String message;

  OAuthFailure(this.code, this.message) : super();

  @override
  String toString() => 'OAuthException: [$code] $message';
}

class OAuthException extends Error {
  final String code;
  final String message;

  OAuthException(this.code, this.message) : super();

  @override
  String toString() => 'OAuthException: [$code] $message';
}

class DatabaseFailure extends Failure {
  final String? message;

  DatabaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}
