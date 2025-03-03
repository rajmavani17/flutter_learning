import 'package:dartz/dartz.dart';
import 'package:tdd_app_test/core/usecase/usecase.dart';
import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/domain/entities/user.dart';
import 'package:tdd_app_test/features/auth/domain/respository/auth_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<List<User>> call() async {
    final result = await _repository.getUsers();
    return result.fold(
      (failure) => Left(failure),
      (userList) => Right(userList),
    );
  }
}
