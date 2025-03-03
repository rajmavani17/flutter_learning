import 'package:equatable/equatable.dart';
import 'package:tdd_app_test/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    required super.statusCode,
  });

  ApiFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
