class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Cache exception occurred']);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network connection failed']);

  @override
  String toString() => message;
}
