import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/data/helper/fetch_weather.dart';
import 'package:modern_weather_getx/data/model/weather_wrapper_model.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxBool _isRefreshing = false.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final weatherData = WeatherWrapperModel().obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool _isThirdRowVisible = false.obs;

  RxBool checkLoading() => _isLoading;

  RxBool checkRefreshing() => _isRefreshing;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  WeatherWrapperModel getWeatherData() => weatherData.value;

  RxInt getIndex() => _currentIndex;

  RxBool getIsThirdRowVisible() => _isThirdRowVisible;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      await fetchWeatherData(value.latitude, value.longitude);
    });
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    return await FetchWeatherApi().processData(lat, lon).then((value) {
      weatherData.value = value;
      _isLoading.value = false;
    });
  }

  Future<void> refreshWeatherData() async {
    _isRefreshing.value = true;
    return await FetchWeatherApi().processData(_latitude.value, _longitude.value).then((value) {
      weatherData.value = value;
      _isRefreshing.value = false;
    });
  }

  void toggleThirdRowVisibility() {
    _isThirdRowVisible.value = !_isThirdRowVisible.value;
  }
}
