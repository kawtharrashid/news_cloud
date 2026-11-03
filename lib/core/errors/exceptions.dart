sealed class AppException implements Exception {
  final String message;

  const AppException({required this.message});
}

final class ServerException extends AppException {
  const ServerException({required super.message});
}

final class NetworkException extends AppException {
  const NetworkException({required super.message});
}

final class TimeoutException extends AppException {
  const TimeoutException({required super.message});
}

final class UnknownException extends AppException {
  const UnknownException({required super.message});
}
