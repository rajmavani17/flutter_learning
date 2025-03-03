import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/pages/additional_forecast_item.dart';
import 'package:weather_app/pages/hourly_forecast_item.dart';

import 'package:weather_app_state/secrets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> weather;
  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'mumbai';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$API_KEY'),
      );
      final Map<String, dynamic> data;
      if (res.statusCode == 200) {
        data = jsonDecode(res.body);
        return data;
      }
    } catch (e) {
      throw Exception(e);
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Current Weather',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                setState(() {
                  weather = getCurrentWeather();
                });
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: weather,
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final data = snapshot.data!;
            final currentWeatherData = data['list'][0];
            final weatherDataList = data['list'];
            final String currentTemperature =
                (currentWeatherData['main']['temp'] - 273.15)
                    .toStringAsFixed(2);
            final String currentSky = currentWeatherData['weather'][0]['main'];
            final String pressure =
                currentWeatherData['main']['pressure'].toString();
            final String humidity =
                currentWeatherData['main']['humidity'].toString();
            final String windSpeed =
                currentWeatherData['wind']['speed'].toString();
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  // "${(currentTemperature - 273.15).toString()}°F",
                                  "$currentTemperature°C",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 75,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  currentSky,
                                  style: TextStyle(
                                    fontSize: 21,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weatherDataList.length,
                      itemBuilder: (context, index) {
                        final item = weatherDataList[index];
                        final time = DateTime.parse(item['dt_txt']);
                        return HourlyForecastItem(
                            icon: item['weather'][0]['main'] == 'Rain' ||
                                    item['weather'][0]['main'] == 'Clouds'
                                ? Icons.cloud
                                : Icons.sunny,
                            time: DateFormat.j().format(time),
                            temperature:
                                "${(item['main']['temp'] - 273.15).toStringAsFixed(2)} °C");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalForecastItem(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: humidity),
                      AdditionalForecastItem(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: windSpeed,
                      ),
                      AdditionalForecastItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: pressure,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
