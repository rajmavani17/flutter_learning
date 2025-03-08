import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/repository/auth_repository.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture call(params) {
    return repository.forgotPassword(email: params);
  }
}
