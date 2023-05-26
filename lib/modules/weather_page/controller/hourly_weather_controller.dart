import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/entities/forecast/forecast_data.dart';
import 'package:weather_app/modules/weather_page/widgets/city_search_box.dart';

import '../../../core/repositories/api_error.dart';
import '../../../core/repositories/weather_repository.dart';

class HourlyWeatherController extends StateNotifier<AsyncValue<ForecastData>> {
  HourlyWeatherController(this._weatherRepository, {required String city})
      : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }
  final HttpWeatherRepository _weatherRepository;

  Future<void> getWeather({required String city}) async {
    try {
      state = const AsyncValue.loading();
      final forecast = await _weatherRepository.getForecast(city: city);
      state = AsyncValue.data(ForecastData.from(forecast));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final hourlyWeatherControllerProvider = StateNotifierProvider.autoDispose<
    HourlyWeatherController, AsyncValue<ForecastData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return HourlyWeatherController(weatherRepository, city: city);
});
