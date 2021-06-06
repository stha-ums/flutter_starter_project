import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class SuccessFalseOnApicallFailure extends Failure {
  final String failureMesage;

  SuccessFalseOnApicallFailure({required this.failureMesage});
}

class InternetConnectionFailure extends Failure {}

class OTPNeededFailure extends Failure {}
