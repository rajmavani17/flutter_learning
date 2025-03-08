import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer({
    required this.repository,
  });

  final OnBoardingRepository repository;

  @override
  ResultFuture<void> call() async {
    return repository.cacheFirstTimer();
  }
}
