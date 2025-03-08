import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/errors/exceptions.dart';
import 'package:education_app/core/common/errors/failures.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/on_boarding/data/datasource/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  OnBoardingRepositoryImpl({
    required this.localDataSource,
  });

  final OnBoardingLocalDataSource localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      final res = await localDataSource.cacheFirstTimer();
      return Right(res);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIsUserFirstTimer() async {
    try {
      final res = await localDataSource.checkIsUserFirstTimer();
      return Right(res);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
