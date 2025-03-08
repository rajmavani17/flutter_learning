import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn({required this.repository});
  final AuthRepository repository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) {
    return repository.signIn(email: params.email, password: params.password);
  }
}

final class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
