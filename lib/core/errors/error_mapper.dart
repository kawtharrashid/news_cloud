import 'package:news_cloud/core/errors/exceptions.dart';
import 'package:news_cloud/core/errors/failure.dart';

class ErrorMapper {
  ErrorMapper._();

  static Failure toFailure(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(exception.message),
      TimeoutException() => TimeoutFailure(exception.message),
      ServerException() => ServerFailure(exception.message),
      UnknownException() => UnknownFailure(exception.message),
    };
  }
}
