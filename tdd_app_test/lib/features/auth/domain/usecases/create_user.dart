import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app_test/core/usecase/usecase.dart';
import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/domain/respository/auth_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthRepository _repository;

  // ResultVoid createUser({
  //   required String createdAt,
  //   required String name,
  //   required String avatar,
  // }) async =>
  //     _repository.createUser(
  //       createdAt: createdAt,
  //       name: name,
  //       avatar: avatar,
  //     );

  @override
  ResultFuture call(CreateUserParams params) async {
    final result = await _repository.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
    );
    return result.fold(
      (failure) => Left(failure),
      (_) => Right(null),
    );
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
