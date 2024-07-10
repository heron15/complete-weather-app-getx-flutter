import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/utils/app_color.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key, required this.globalController});

  final GlobalController globalController;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    getAddress(
      widget.globalController.getLatitude().value,
      widget.globalController.getLongitude().value,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 35,
            fontWeight: FontWeight.w400,
            height: 2,
          ),
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

  getAddress(lat, lon) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMark[0];
    setState(() {
      city = place.locality ?? "Unknown";
    });
  }
}
