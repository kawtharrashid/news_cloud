import 'dart:developer';

import 'package:dio/dio.dart';

class DioErrorMapper {
  static String map(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.badResponse:
        return _statusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

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
        return 'Something went wrong. Please try again.';
    }
  }

  static String _statusCode(int? statusCode) {
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
