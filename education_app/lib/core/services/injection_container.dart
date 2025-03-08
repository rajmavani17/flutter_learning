import 'package:education_app/src/on_boarding/data/datasource/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/respository/on_boarding_repository_impl.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_user_if_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  //onboarding feature
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cachedFirstTimer: sl(),
        checkUserIfFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CacheFirstTimer(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckUserIfFirstTimer(
        repository: sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(
        localDataSource: sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    )
    ..registerLazySingleton(() => prefs);
}
