import 'package:education_app/core/common/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kFirstTimerKey = 'isFirstTimer';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();
  Future<bool> checkIsUserFirstTimer();
}

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheFirstTimer() async {
    await sharedPreferences.setBool(kFirstTimerKey, false);
  }

  @override
  Future<bool> checkIsUserFirstTimer() async {
    try {
      return sharedPreferences.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
        statusCode: e,
      );
    }
  }
}
