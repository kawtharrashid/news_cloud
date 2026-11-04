import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_cloud/core/errors/exceptions.dart';

class DioErrorMapper {
  DioErrorMapper._();

  static AppException map(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException(
          message: 'Please check your internet connection and try again.',
        );
      case DioExceptionType.connectionError:
        return const NetworkException(
          message:
              'No internet connection. Please check your connection and try again.',
        );

      case DioExceptionType.cancel:
        return const UnknownException(
          message: 'Request was cancelled.',
        );

      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.transformTimeout:
        log('================ DIO ERROR ================');
        log('Type: ${error.type}');
        log('Message: ${error.message}');
        log('Error: ${error.error}');
        log('Response: ${error.response}');
        log('Status Code: ${error.response?.statusCode}');
        log('Response Data: ${error.response?.data}');
        log('Request URL: ${error.requestOptions.uri}');
        log('===========================================');
        return const UnknownException(
          message: 'Something went wrong. Please try again.',
        );
      case DioExceptionType.badResponse:
        return _statusCode(error.response?.statusCode);
    }
  }

  static AppException _statusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
      case 404:
      case 429:
      case 500:
        return ServerException(
          message: _statusMessage(statusCode!),
        );
      default:
        return const ServerException(
          message: 'Server error. Please try again.',
        );
    }
  }

  static String _statusMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Unauthorized. Check your API key.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Not found.';
      case 429:
        return 'Too many requests. Try again later.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Server error. Please try again.';
    }
  }
}
