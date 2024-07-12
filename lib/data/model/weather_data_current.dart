import 'package:modern_weather_getx/data/model/weather_data.dart';

class WeatherDataCurrent {
  final Current current;

  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) => WeatherDataCurrent(
        current: Current.fromJson(json['current']),
      );
}

class Current {
  int? dt;
  int? temp;
  int? sunrise;
  int? sunset;
  int? humidity;
  int? clouds;
  double? uvIndex;
  int? feelsLike;
  double? windSpeed;
  List<WeatherData>? weather;

  Current({
    this.dt,
    this.temp,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.clouds,
    this.uvIndex,
    this.feelsLike,
    this.windSpeed,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)!.round(),
        sunrise: json['sunrise'] as int?,
        sunset: json['sunset'] as int?,
        feelsLike: (json['feels_like'] as num?)!.round(),
        humidity: json['humidity'] as int?,
        uvIndex: (json['uvi'] as num?)?.toDouble(),
        clouds: json['clouds'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => WeatherData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'sunrise': sunrise,
        'sunset': sunset,
        'feels_like': feelsLike,
        'uvi': uvIndex,
        'humidity': humidity,
        'clouds': clouds,
        'wind_speed': windSpeed,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
