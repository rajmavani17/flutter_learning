import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final String email = event.email;
        final String password = event.password;
        if (password.length < 6) {
          emit(
            AuthFailure(
              error: 'Length of password should be greater than 6',
            ),
          );
          return;
        }

        return await Future.delayed(Duration(seconds: 3), () {
          emit(
            AuthSuccess(
              uid: email,
            ),
          );
        });
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        return await Future.delayed(Duration(seconds: 2), () {
          emit(
            AuthInitial(),
          );
        });
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
