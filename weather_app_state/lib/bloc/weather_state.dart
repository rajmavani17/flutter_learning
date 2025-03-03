part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final List<WeatherModel> weatherModels;

  WeatherSuccess({required this.weatherModels});
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure({required this.error});

}

final class WeatherLoading extends WeatherState {}
