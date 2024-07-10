import 'package:get/get.dart';
import 'package:modern_weather_getx/views/screens/home_screen.dart';
import 'package:modern_weather_getx/views/screens/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";
  static const String homeScreen = "/home_screen";

  static List<GetPage> routes = [
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}
