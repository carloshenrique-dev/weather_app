import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/entities/weather/weather_data.dart';
import 'package:weather_app/modules/weather_page/widgets/city_search_box.dart';

import '../../../core/repositories/api_error.dart';
import '../../../core/repositories/weather_repository.dart';

class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {required this.city})
      : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }
  final HttpWeatherRepository _weatherRepository;
  final String city;

  Future<void> getWeather({required String city}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(city: city);
      state = AsyncValue.data(WeatherData.from(weather));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return CurrentWeatherController(weatherRepository, city: city);
});
