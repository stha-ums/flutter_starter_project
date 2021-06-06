class ServerException implements Exception {}

class CacheException implements Exception {}

class InternetConnectionException implements Exception {}

class SuccessFalseOnApicallException implements Exception {
  final String errorMessage;

  SuccessFalseOnApicallException({required this.errorMessage});
}

class PhoneNumberAddOTPRemaining implements Exception {}
