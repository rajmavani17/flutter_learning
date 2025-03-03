import 'dart:convert';

import 'package:weather_app_state/data/data_provider/weather_data_provider.dart';
import 'package:weather_app_state/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);
  Future<List<WeatherModel>> getCurrentWeather() async {
    try {
      String cityName = 'Pune';
      final data = await weatherDataProvider.getCurrentWeather(cityName);
      final weatherData = jsonDecode(data);

      if (weatherData['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.getWeatherForecastData(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
