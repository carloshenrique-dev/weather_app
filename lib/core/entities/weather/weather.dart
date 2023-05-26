import 'package:flutter/foundation.dart';

class WeatherParams {
  final double temp;
  final double tempMin;
  final double tempMax;
  WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherParams.fromMap(Map<String, dynamic> map) {
    return WeatherParams(
      temp: map['temp'] != null ? double.parse(map['temp'].toString()) : 0,
      tempMin: map['temp_min'] != null
          ? double.parse(map['temp_min'].toString())
          : 0,
      tempMax: map['temp_max'] != null
          ? double.parse(map['temp_max'].toString())
          : 0,
    );
  }

  @override
  String toString() =>
      'WeatherParams(temp: $temp, tempMin: $tempMin, tempMax: $tempMax)';

  @override
  bool operator ==(covariant WeatherParams other) {
    if (identical(this, other)) return true;

    return other.temp == temp &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax;
  }

  @override
  int get hashCode => temp.hashCode ^ tempMin.hashCode ^ tempMax.hashCode;
}

class WeatherInfo {
  final String main;
  final String description;
  final String icon;
  WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromMap(Map<String, dynamic> map) {
    return WeatherInfo(
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  @override
  String toString() =>
      'WeatherInfo(main: $main, description: $description, icon: $icon)';

  @override
  bool operator ==(covariant WeatherInfo other) {
    if (identical(this, other)) return true;

    return other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode => main.hashCode ^ description.hashCode ^ icon.hashCode;
}

/// Weather data parsed from the API response (not used directly in the UI)
class Weather {
  final List<WeatherInfo> weatherInfo;
  final WeatherParams? weatherParams;
  final int dt;
  Weather({
    required this.weatherInfo,
    this.weatherParams,
    required this.dt,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      weatherInfo: List<WeatherInfo>.from(
        (map['weather'] as List).map<WeatherInfo>(
          (x) => WeatherInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
      weatherParams: map['main'] != null
          ? WeatherParams.fromMap(map['main'] as Map<String, dynamic>)
          : null,
      dt: map['dt'] as int,
    );
  }

  @override
  String toString() =>
      'Weather(weatherInfo: $weatherInfo, weatherParams: $weatherParams, dt: $dt)';

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return listEquals(other.weatherInfo, weatherInfo) &&
        other.weatherParams == weatherParams &&
        other.dt == dt;
  }

  @override
  int get hashCode =>
      weatherInfo.hashCode ^ weatherParams.hashCode ^ dt.hashCode;
}
