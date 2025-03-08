import 'package:education_app/core/utils/typedef.dart';

abstract class OnBoardingRepository {
  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIsUserFirstTimer();
}
