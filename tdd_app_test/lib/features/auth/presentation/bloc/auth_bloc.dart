import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app_test/features/auth/domain/entities/user.dart';
import 'package:tdd_app_test/features/auth/domain/usecases/create_user.dart';
import 'package:tdd_app_test/features/auth/domain/usecases/get_users.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }
  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    emit(CreatingUser());
    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));
    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
        ),
      ),
      (_) => emit(
        UserCreated(),
      ),
    );
  }

  Future<void> _getUsersHandler(
      GetUsersEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    emit(GettingUser());

    final result = await _getUsers();
    result.fold(
      (failure) {
        return emit(
          AuthError(
            message: failure.errorMessage,
          ),
        );
      },
      (users) {
        return emit(
          UsersLoaded(users),
        );
      },
    );
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;
}
