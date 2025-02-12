import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/respository/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/respository/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/respository/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(
          AuthInitial(),
        ) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_signUpCurrentUser);
    on<AuthLogin>(_loginCurrentUser);
    on<AuthIsCurrentUserLoggedIn>(_currentUserLoggedIn);
  }

  void _signUpCurrentUser(AuthSignup event, Emitter<AuthState> emit) async {
    final response = await _userSignup(
      UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _loginCurrentUser(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
      UserLoginParamas(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _currentUserLoggedIn(
    AuthIsCurrentUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user: user),
    );
  }
}
