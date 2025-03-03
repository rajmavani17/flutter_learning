import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final String date;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.date,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    int? currentPressure,
    double? currentWindSpeed,
    int? currentHumidity,
    String? date,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'date': date,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'] as double,
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: currentWeatherData['main']['pressure'] as int,
      currentWindSpeed: currentWeatherData['wind']['speed'] as double,
      currentHumidity: currentWeatherData['main']['humidity'] as int,
      date: currentWeatherData['dt_txt'] as String,
    );
  }

  static List<WeatherModel> getWeatherForecastData(Map<String, dynamic> map) {
    int len = map['list'].length;
    List<WeatherModel> result = [];
    for (int i = 0; i < len; i++) {
      final currentWeatherData = map['list'][i];
      final weather = WeatherModel(
        currentTemp: currentWeatherData['main']['temp'] as double,
        currentSky: currentWeatherData['weather'][0]['main'] as String,
        currentPressure: currentWeatherData['main']['pressure'] as int,
        currentWindSpeed: currentWeatherData['wind']['speed'] as double,
        currentHumidity: currentWeatherData['main']['humidity'] as int,
        date: currentWeatherData['dt_txt'] as String,
      );
      result.add(weather);
    }
    return result;
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, date: $date)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.date == date;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        date.hashCode;
  }
}
