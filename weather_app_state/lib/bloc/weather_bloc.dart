import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_state/data/repository/weather_repository.dart';
import 'package:weather_app_state/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);
  }

  _getCurrentWeather(WeatherFetched event, Emitter emit) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getCurrentWeather();
      emit(
        WeatherSuccess(
          weatherModels: weather,
        ),
      );
    } catch (error) {
      emit(
        WeatherFailure(
          error: error.toString(),
        ),
      );
    }
  }
}
