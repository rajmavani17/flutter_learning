import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
