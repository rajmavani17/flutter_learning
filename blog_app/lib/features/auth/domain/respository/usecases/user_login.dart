import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, UserLoginParamas> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParamas params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParamas {
  final String email;
  final String password;

  UserLoginParamas({
    required this.email,
    required this.password,
  });
}
