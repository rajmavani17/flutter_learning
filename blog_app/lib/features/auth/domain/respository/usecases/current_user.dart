import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/respository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }
}
