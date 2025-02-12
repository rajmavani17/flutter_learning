import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/respository/auth_repository.dart';

class AuthRespositoriesImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  AuthRespositoriesImpl(
    this.remoteDataSource,
    this.internetConnectionChecker,
  );

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
    // try {
    //   final user = await remoteDataSource.loginWithEmailPassword(
    //     email: email,
    //     password: password,
    //   );
    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(
    //     Failure(e.message),
    //   );
    // }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
    // try {
    //   final User user = await remoteDataSource.signUpWithEmailPassword(
    //     name: name,
    //     email: email,
    //     password: password,
    //   );
    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!(await internetConnectionChecker.isConnected)) {
        return left(
          Failure("Internet Connection Required"),
        );
      }
      final User user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!(await internetConnectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure("User Not Logged In"));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final currentUser = await remoteDataSource.getCurrentUserData();
      if (currentUser == null) {
        return left(Failure("User Not Logged In"));
      }
      return right(currentUser);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
