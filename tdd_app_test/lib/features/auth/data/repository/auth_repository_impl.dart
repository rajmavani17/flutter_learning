import 'package:dartz/dartz.dart';
import 'package:tdd_app_test/core/errors/exceptions.dart';
import 'package:tdd_app_test/core/errors/failure.dart';
import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:tdd_app_test/features/auth/domain/entities/user.dart';
import 'package:tdd_app_test/features/auth/domain/respository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final List<User> userList = await _remoteDataSource.getUsers();
      return Right(userList);
    } on ApiException catch (e) {
      return left(ApiFailure.fromException(e));
    }
  }
}
