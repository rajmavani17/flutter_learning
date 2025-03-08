import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  ResultFuture<void> forgotPassword({
    required String email,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
