import 'package:dartz/dartz.dart';
import 'package:tdd_app_test/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef StringMap = Map<String, dynamic>;
