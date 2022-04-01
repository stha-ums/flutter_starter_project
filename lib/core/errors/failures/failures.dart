/// this is the failure data that is represendted to user incase of failure.
abstract class Failure {
  final String message;
  Failure({this.message = 'Unkown Error Occured'});
}

class ServerFailure extends Failure {
  ServerFailure({
    String message = "Error In Server",
  }) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String message = "Error while Cacheing"})
      : super(message: message);
}
