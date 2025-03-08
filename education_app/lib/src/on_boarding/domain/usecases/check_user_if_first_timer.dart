import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

class CheckUserIfFirstTimer extends UsecaseWithoutParams<bool> {
  CheckUserIfFirstTimer({
    required this.repository,
  });

  OnBoardingRepository repository;

  @override
  ResultFuture<bool> call() {
    return repository.checkIsUserFirstTimer();
  }
}
