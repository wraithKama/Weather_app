import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_final/domain/json_convertors/coord.dart';
import 'package:weather_app_final/domain/json_convertors/weather_data.dart';

abstract class Api {
  // Ссылка для получения координат
//https://api.openweathermap.org/data/2.5/weather?q=London&appid=8a00668c6b556cefecfd7888df2a5aff

  static final _client = HttpClient();
  static const scheme = 'https';
  static const host = 'api.openweathermap.org';
  static final apiKey = dotenv.get('API_KEY');

// Ссылка для получения координат
//https://api.openweathermap.org/data/2.5/weather?q=London&appid=8a00668c6b556cefecfd7888df2a5aff

  static Future<Coord> getCoords({String? cityName = 'Ташкент'}) async {
    const path = 'data/2.5/weather';

    Uri url = Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'lang': 'ru',
      },
    );

    try {
      final data = await _jsonRequest(url);
      final coords = Coord.fromJson(data);
      return coords;
    } catch (e) {
      Uri url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: {
          'q': 'Tashkent',
          'appid': apiKey,
          'lang': 'ru',
        },
      );
      final data = await _jsonRequest(url);
      final coords = Coord.fromJson(data);
      return coords;
    }
  }

  // Ссылка для получения погоды
//https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutely&appid=8a00668c6b556cefecfd7888df2a5aff

  static Future<WeatherData?> getWeather(Coord? coords) async {
    if (coords != null) {
      const weatherPath = 'data/2.5/onecall';

      Uri url = Uri(
        scheme: scheme,
        host: host,
        path: weatherPath,
        queryParameters: {
          'lat': coords.lat.toString(),
          'lon': coords.lon.toString(),
          'lang': 'ru',
          'exclude': 'hourly,minutely',
          'appid': apiKey,
        },
      );
      
      final data = await _jsonRequest(url);
      final weatherData = WeatherData.fromJson(data);
      return weatherData;
    }
    return null;
  }

  static Future<Map<String, dynamic>> _jsonRequest(Uri url) async {
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();

      final json = await response.transform(utf8.decoder).toList();
      final jsonString = json.join();
      print('Request ---- ${request}');
      // print('************');
      print('Response ------ ${response}');
      // print('************');
      // print('json ------ $json ');
      // print('***********');
      // print('jsonString ------- $jsonString');

      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      // print('************');
      // print('data ----------- $data');
      return data;
    } catch (e) {
      print(e);
    }
    return {};
  }
}
