import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/api/api.dart';
import 'package:weather_app/core/entities/forecast/forecast.dart';
import 'package:weather_app/core/entities/weather/weather.dart';

import 'api_error.dart';

class HttpWeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  final OpenWeatherMapAPI api;
  final http.Client client;

  Future<Forecast> getForecast({required String city}) => _getData(
        uri: api.forecast(city),
        builder: (data) => Forecast.fromMap(data),
      );

  Future<Weather> getWeather({required String city}) => _getData(
        uri: api.weather(city),
        builder: (data) => Weather.fromMap(data),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw const APIError.invalidApiKey();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }
}

final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
  return HttpWeatherRepository(
    api: OpenWeatherMapAPI('fa188891399e81253785fadcf127625e'),
    client: http.Client(),
  );
});
