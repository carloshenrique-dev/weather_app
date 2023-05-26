import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/entities/weather/weather_data.dart';
import 'package:weather_app/modules/weather_page/widgets/city_search_box.dart';

import 'package:weather_app/modules/weather_page/widgets/weather_icon_image.dart';

import '../controller/current_weather_controller.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          city,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.black,
              ),
        ),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          ),
          error: (e, __) => Text(e.toString()),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text(
          temp,
          style: textTheme.displayMedium!.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          highAndLow,
          style: textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
