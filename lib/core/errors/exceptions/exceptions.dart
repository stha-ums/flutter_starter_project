class ServerException implements Exception {
  final String message;
  final String? description;
  final StackTrace? stackTrace;
  final int? statusCode;

  ServerException(
      {this.message = "Something went wrong",
      this.stackTrace,
      this.description,
      this.statusCode});
  @override
  String toString() => '[$runtimeType]=>$message';
}

class CacheException implements Exception {
  final String message;
  final String? description;
  final StackTrace? stackTrace;

  CacheException(
      {this.message = "Something went wrong",
      this.stackTrace,
      this.description});
  @override
  String toString() => '[$runtimeType]=>$message';
}
