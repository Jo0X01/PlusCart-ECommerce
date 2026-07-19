import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class Failure {
  final String errorMsg;
  const Failure(this.errorMsg);
}

class DioServerFailure extends Failure {
  DioServerFailure(super.errorMsg);

  static bool isException(Object e) => e is DioException;

  factory DioServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return DioServerFailure(
          "Connection timed out. Please check your internet and try again.",
        );

      case DioExceptionType.sendTimeout:
        return DioServerFailure(
          "Sending data took too long. Please try again.",
        );

      case DioExceptionType.receiveTimeout:
        return DioServerFailure(
          "The server took too long to respond. Please try again.",
        );

      case DioExceptionType.badCertificate:
        return DioServerFailure(
          "Secure connection failed. The server's certificate is not trusted.",
        );

      case DioExceptionType.badResponse:
        return DioServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );

      case DioExceptionType.cancel:
        return DioServerFailure("Request was cancelled.");

      case DioExceptionType.connectionError:
        return DioServerFailure(
          "No internet connection. Please check your network and try again.",
        );

      case DioExceptionType.unknown:
        return DioServerFailure(
          "Something went wrong. Please try again later.",
        );

      case DioExceptionType.transformTimeout:
        return DioServerFailure(
          "Data processing took too long. Please try again.",
        );
    }
  }
  factory DioServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400) {
      return DioServerFailure("Bad request. Please check your input.");
    } else if (statusCode == 401) {
      return DioServerFailure("Unauthorized. Please log in again.");
    } else if (statusCode == 403) {
      return DioServerFailure("You don't have permission to do this.");
    } else if (statusCode == 404) {
      return DioServerFailure("Requested resource not found.");
    } else if (statusCode == 500) {
      return DioServerFailure("Server error. Please try again later.");
    } else {
      return DioServerFailure("Something went wrong. Please try again.");
    }
  }
}

class SupabaseFailure extends Failure {
  SupabaseFailure(super.errorMsg);

  static bool isException(Object e) =>
      e is AuthException ||
      e is PostgrestException ||
      e is StorageException ||
      e is AuthRetryableFetchException;

  factory SupabaseFailure.fromException(Object exception) {
    if (exception is AuthException) {
      return SupabaseFailure.fromAuthException(exception);
    } else if (exception is PostgrestException) {
      return SupabaseFailure.fromPostgrestException(exception);
    } else if (exception is StorageException) {
      return SupabaseFailure("File upload failed. Please try again.");
    } else {
      log(exception.toString());
      return SupabaseFailure("Something went wrong. Please try again.");
    }
  }

  factory SupabaseFailure.fromAuthException(AuthException exception) {
    switch (exception.code) {
      case 'invalid_credentials':
        return SupabaseFailure("Incorrect email or password.");

      case 'email_not_confirmed':
        return SupabaseFailure("Please confirm your email before logging in.");

      case 'user_already_exists':
      case 'email_exists':
        return SupabaseFailure("An account with this email already exists.");

      case 'weak_password':
        return SupabaseFailure(
          "Password is too weak. Use at least 6 characters.",
        );

      case 'over_request_rate_limit':
        return SupabaseFailure("Too many attempts. Please wait and try again.");

      case 'user_not_found':
        return SupabaseFailure("No account found with this email.");

      case 'session_expired':
      case 'refresh_token_not_found':
        return SupabaseFailure(
          "Your session has expired. Please log in again.",
        );

      case 'signup_disabled':
        return SupabaseFailure("Sign-ups are currently disabled.");

      case 'validation_failed':
        return SupabaseFailure("Please check your input and try again.");

      default:
        log(
          "Unhandled AuthException code: ${exception.code}, message: ${exception.message}",
        );
        return SupabaseFailure("Authentication failed. Please try again.");
    }
  }

  factory SupabaseFailure.fromPostgrestException(PostgrestException exception) {
    switch (exception.code) {
      case '23505': // unique_violation
        return SupabaseFailure("This value already exists.");
      case '23503': // foreign_key_violation
        return SupabaseFailure(
          "This action references data that doesn't exist.",
        );
      case '42501': // insufficient_privilege (RLS policy block)
        return SupabaseFailure("You don't have permission to do this.");
      default:
        log(
          "Unhandled PostgrestException code: ${exception.code}, message: ${exception.message}",
        );
        return SupabaseFailure("Something went wrong. Please try again.");
    }
  }
}
