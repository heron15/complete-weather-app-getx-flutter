import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/const_function.dart';
import 'package:modern_weather_getx/views/screens/search_screen.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    super.key,
    required this.globalController,
  });

  final GlobalController globalController;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = "";

  @override
  void initState() {
    super.initState();
    _updateCity();
    _updateDate();
    widget.globalController.selectedPlace.listen((place) {
      if (place.isNotEmpty) {
        _updateCity();
        _updateDate();
      }
    });
  }

  void _updateCity() async {
    String updatedCity = await getAddress(
      widget.globalController.getLatitude().value,
      widget.globalController.getLongitude().value,
    );
    setState(() {
      city = updatedCity;
    });
  }

  void _updateDate() {
    setState(() {
      date = ConstFunction.getFormatTime(
          widget.globalController.getWeatherData().getCurrentWeather().current.dt ?? 0, "yMMMMd");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                city,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  height: 2,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchScreen(),
                );
              },
              icon: const Icon(
                Icons.search,
                color: AppColor.white,
              ),
            )
          ],
        ),
        Text(
          date,
          style: TextStyle(
            color: AppColor.white.withAlpha(150),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Future<String> getAddress(double lat, double lon) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    if (placeMark.isNotEmpty) {
      Placemark place = placeMark[0];
      String? cityName = place.locality;
      if (cityName == null || cityName.isEmpty) {
        cityName = place.subAdministrativeArea;
      }
      if (cityName == null || cityName.isEmpty) {
        cityName = place.administrativeArea;
      }
      if (cityName == null || cityName.isEmpty) {
        cityName = place.country;
      }
      return cityName ?? "Unknown";
    }
    return "Unknown";
  }
}
