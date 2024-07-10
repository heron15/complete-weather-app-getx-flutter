import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
  final Connectivity _connectivity = Connectivity();
  var connectionStatus = 0.obs;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

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
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location services are disabled.");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied.");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _latitude.value = position.latitude;
    _longitude.value = position.longitude;

    await fetchWeatherData(position.latitude, position.longitude);
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    final fetchedWeather = await FetchWeatherApi().processData(lat, lon);
    weatherData.value = fetchedWeather;
    _isLoading.value = false;
  }

  Future<void> refreshWeatherData() async {
    _isRefreshing.value = true;
    final refreshedWeather = await FetchWeatherApi().processData(_latitude.value, _longitude.value);
    weatherData.value = refreshedWeather;
    _isRefreshing.value = false;
  }

  void toggleThirdRowVisibility() {
    _isThirdRowVisible.value = !_isThirdRowVisible.value;
  }

  Future<void> initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connectionStatus.value = 1;
        bool hasInternet = await _checkInternetAccess();
        if (!hasInternet) {
          connectionStatus.value = 0;
        } else if (_isLoading.value) {
          await fetchWeatherData(_latitude.value, _longitude.value);
        }
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        connectionStatus.value = 3;
        break;
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}