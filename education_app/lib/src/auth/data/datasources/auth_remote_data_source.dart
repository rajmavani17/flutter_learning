import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestrore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestrore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LocalUserModel> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(
      {required UpdateUserAction action, required userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
