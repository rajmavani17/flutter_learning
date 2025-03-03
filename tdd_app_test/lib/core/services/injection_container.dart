import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:tdd_app_test/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:tdd_app_test/features/auth/data/repository/auth_repository_impl.dart';
import 'package:tdd_app_test/features/auth/domain/respository/auth_repository.dart';
import 'package:tdd_app_test/features/auth/domain/usecases/create_user.dart';
import 'package:tdd_app_test/features/auth/domain/usecases/get_users.dart';
import 'package:tdd_app_test/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => AuthBloc(createUser: sl(), getUsers: sl()))
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(() => http.Client());
}
