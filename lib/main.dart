import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_weather_getx/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const ModernWeather());
  });
}
