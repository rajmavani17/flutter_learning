import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  const SignUp({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(SignUpParams params) async {
    return repository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

final class SignUpParams extends Equatable {
  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  const SignUpParams.empty()
      : this(
          fullName: '',
          email: '',
          password: '',
        );

  final String fullName;
  final String email;
  final String password;

  @override
  List<String> get props => [fullName, email, password];
}
