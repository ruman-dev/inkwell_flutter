class Failure {
  final String message;

  const Failure({required this.message});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No internet connection. Please check your network."});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}
