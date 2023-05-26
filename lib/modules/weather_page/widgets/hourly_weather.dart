import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/entities/weather/weather_data.dart';

import 'package:weather_app/modules/weather_page/widgets/weather_icon_image.dart';

import '../controller/hourly_weather_controller.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastDataValue = ref.watch(hourlyWeatherControllerProvider);
    return forecastDataValue.when(
      data: (forecastData) {
        final items = [0, 8, 16, 24, 32];
        return HourlyWeatherRow(
          weatherDataItems: [
            for (var i in items) forecastData.list[i],
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        )),
      ),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class HourlyWeatherRow extends StatelessWidget {
  const HourlyWeatherRow({Key? key, required this.weatherDataItems})
      : super(key: key);
  final List<WeatherData> weatherDataItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: weatherDataItems
          .map((data) => HourlyWeatherItem(data: data))
          .toList(),
    );
  }
}

class HourlyWeatherItem extends ConsumerWidget {
  const HourlyWeatherItem({Key? key, required this.data}) : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    const fontWeight = FontWeight.normal;
    final temp = data.temp.celsius.toInt().toString();
    return Expanded(
      child: Column(
        children: [
          Text(
            DateFormat.E().format(data.date),
            style: textTheme.bodySmall!.copyWith(
              fontWeight: fontWeight,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          WeatherIconImage(iconUrl: data.iconUrl, size: 55),
          const SizedBox(height: 8),
          Text(
            '$temp°',
            style: textTheme.bodyLarge!.copyWith(
              fontWeight: fontWeight,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
