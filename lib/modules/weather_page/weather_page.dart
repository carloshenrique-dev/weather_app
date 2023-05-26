import 'package:flutter/material.dart';

import 'package:weather_app/modules/weather_page/widgets/city_search_box.dart';
import 'package:weather_app/modules/weather_page/widgets/current_weather.dart';
import 'package:weather_app/modules/weather_page/widgets/hourly_weather.dart';
import 'package:rive/rive.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const SizedBox(
          width: double.infinity,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: RiveAnimation.asset(
                    'assets/animations/weather_animation.riv',
                  ),
                ),
                SearchBox(),
                Spacer(),
                CurrentWeather(),
                Spacer(),
                HourlyWeather(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
