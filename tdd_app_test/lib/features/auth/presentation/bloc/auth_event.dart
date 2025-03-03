part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object> get props => [name, createdAt, avatar];
}

class GetUsersEvent extends AuthEvent {
  const GetUsersEvent();
}
