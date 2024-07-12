import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modern_weather_getx/data/helper/fetch_weather.dart';
import 'package:modern_weather_getx/data/model/weather_wrapper_model.dart';
import 'package:modern_weather_getx/utils/api_url.dart';
import 'package:uuid/uuid.dart';

class GlobalController extends GetxController {
  final RxBool _isLoadingWeatherData = true.obs;
  final RxBool _isRefreshing = false.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final weatherData = WeatherWrapperModel().obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool _isThirdRowVisible = false.obs;
  final Connectivity _connectivity = Connectivity();
  final RxInt _connectionStatus = 0.obs;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final RxString _sessionToken = "".obs;
  final RxList<dynamic> _suggestionsList = [].obs;
  final RxBool _isSearching = false.obs;
  final RxBool _isLoadingWeatherForPlace = false.obs;
  final RxString _selectedPlace = ''.obs;

  RxBool checkLoading() => _isLoadingWeatherData;

  RxBool checkRefreshing() => _isRefreshing;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  WeatherWrapperModel getWeatherData() => weatherData.value;

  RxInt getIndex() => _currentIndex;

  RxBool getIsThirdRowVisible() => _isThirdRowVisible;

  RxInt getConnectionStatus() => _connectionStatus;

  RxList getSuggestionsList() => _suggestionsList;

  RxBool getIsSearching() => _isSearching;

  RxBool get isLoadingWeatherForPlace => _isLoadingWeatherForPlace;

  RxString get selectedPlace => _selectedPlace;

  @override
  void onInit() {
    super.onInit();
    getLocation();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _sessionToken.value = const Uuid().v4();
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
    _isLoadingWeatherData.value = false;
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
        _connectionStatus.value = 1;
        bool hasInternet = await _checkInternetAccess();
        if (!hasInternet) {
          _connectionStatus.value = 0;
        } else if (_isLoadingWeatherData.value) {
          getLocation();
        }
        break;
      case ConnectivityResult.none:
        _connectionStatus.value = 0;
        break;
      default:
        _connectionStatus.value = 3;
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

  Future<void> getSuggestions(String input) async {
    if (input.isEmpty) {
      _suggestionsList.clear();
      return;
    }

    _isSearching.value = true;

    var response = await http.get(Uri.parse(ApiUrl.placeApi(_sessionToken.value, input)));

    if (response.statusCode == 200) {
      _suggestionsList.value = jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Failed to load suggestions');
    }

    _isSearching.value = false;
  }

  void clearSuggestions() {
    _suggestionsList.clear();
  }

  Future<void> fetchWeatherDataForPlace(String placeName) async {
    _isLoadingWeatherForPlace.value = true;

    List<Location> locations = await locationFromAddress(placeName);
    if (locations.isNotEmpty) {
      double lat = locations.first.latitude;
      double lon = locations.first.longitude;
      await fetchWeatherData(lat, lon);

      _latitude.value = lat;
      _longitude.value = lon;
    }

    _isLoadingWeatherForPlace.value = false;
  }

  void setSelectedPlace(String place) {
    _selectedPlace.value = place;
  }
}
