part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class CreatingUser extends AuthState {
  const CreatingUser();
}

final class GettingUser extends AuthState {
  const GettingUser();
}

final class UserCreated extends AuthState {
  const UserCreated();
}

final class UsersLoaded extends AuthState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

final class AuthError extends AuthState {
  final String message;

  const AuthError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
