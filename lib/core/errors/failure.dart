import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMsg;
  const Failure(this.errorMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          "Connection timed out. Please check your internet and try again.",
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure("Sending data took too long. Please try again.");

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          "The server took too long to respond. Please try again.",
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          "Secure connection failed. The server's certificate is not trusted.",
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure("Request was cancelled.");

      case DioExceptionType.connectionError:
        return ServerFailure(
          "No internet connection. Please check your network and try again.",
        );

      case DioExceptionType.unknown:
        return ServerFailure("Something went wrong. Please try again later.");

      case DioExceptionType.transformTimeout:
        return ServerFailure(
          "Data processing took too long. Please try again.",
        );
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400) {
      return ServerFailure("Bad request. Please check your input.");
    } else if (statusCode == 401) {
      return ServerFailure("Unauthorized. Please log in again.");
    } else if (statusCode == 403) {
      return ServerFailure("You don't have permission to do this.");
    } else if (statusCode == 404) {
      return ServerFailure("Requested resource not found.");
    } else if (statusCode == 500) {
      return ServerFailure("Server error. Please try again later.");
    } else {
      log(response.toString());
      log(statusCode.toString());
      return ServerFailure("Something went wrong. Please try again.");
    }
  }
}
