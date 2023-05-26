library forecast;

import 'package:flutter/foundation.dart';

import 'package:weather_app/core/entities/weather/weather.dart';

class Forecast {
  final List<Weather> list;
  Forecast({
    this.list = const [],
  });

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      list: List<Weather>.from(
        (map['list'] as List).map<Weather>(
          (x) => Weather.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'Forecast(list: $list)';

  @override
  bool operator ==(covariant Forecast other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}
