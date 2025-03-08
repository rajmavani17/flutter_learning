import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/errors/exceptions.dart';
import 'package:education_app/core/common/errors/failures.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authRemoteDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      final res = await _authRemoteDataSource.forgotPassword(email);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res =
          await _authRemoteDataSource.signIn(email: email, password: password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _authRemoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _authRemoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
