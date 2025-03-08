import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_user_if_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cachedFirstTimer,
    required CheckUserIfFirstTimer checkUserIfFirstTimer,
  })  : _cachedFirstTimer = cachedFirstTimer,
        _checkUserIfFirstTimer = checkUserIfFirstTimer,
        super(
          const OnBoardingInitial(),
        );

  final CacheFirstTimer _cachedFirstTimer;
  final CheckUserIfFirstTimer _checkUserIfFirstTimer;

  Future<void> cacheFirstTimer() async {
    final result = await _cachedFirstTimer();

    result.fold(
      (failure) {
        return emit(OnBoardingError(message: failure.message));
      },
      (_) {
        return emit(const UserCached());
      },
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    final result = await _checkUserIfFirstTimer();
    return result.fold(
      (failure) {
        return emit(
          const OnBoardingStatus(isFirstTimer: true),
        );
      },
      (status) {
        return emit(
          OnBoardingStatus(isFirstTimer: status),
        );
      },
    );
  }
}
