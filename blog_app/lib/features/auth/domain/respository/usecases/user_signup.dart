import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/respository/auth_repository.dart';

class UserSignup implements Usecase<User, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignup(
    this.authRepository,
  );

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
