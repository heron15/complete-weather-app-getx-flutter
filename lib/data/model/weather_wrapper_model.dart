import 'package:modern_weather_getx/data/model/weather_data_current.dart';
import 'package:modern_weather_getx/data/model/weather_data_daily.dart';
import 'package:modern_weather_getx/data/model/weather_data_hourly.dart';

class WeatherWrapperModel {
  final WeatherDataCurrent? weatherDataCurrent;
  final WeatherDataHourly? weatherDataHourly;
  final WeatherDataDaily? weatherDataDaily;

  WeatherWrapperModel([
    this.weatherDataCurrent,
    this.weatherDataHourly,
    this.weatherDataDaily,
  ]);

  WeatherDataCurrent getCurrentWeather() => weatherDataCurrent!;

  WeatherDataHourly getHourlyWeather() => weatherDataHourly!;

  WeatherDataDaily getDailyWeather() => weatherDataDaily!;
}
