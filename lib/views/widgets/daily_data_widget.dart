import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modern_weather_getx/data/model/weather_data_daily.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';

class DailyDataWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyDataWidget({super.key, required this.weatherDataDaily});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: const Text(
            "Next 7 Days",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
          width: double.maxFinite,
          height: 1,
          color: AppColor.dividerLine.withAlpha(60),
        ),
        const SizedBox(height: 20),
        dailyList(),
      ],
    );
  }

  Widget dailyList() {
    return Column(
      children: weatherDataDaily.daily.take(7).map(
        (item) {
          return Container(
            height: 60,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColor.dividerLine.withAlpha(70),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getDay(item.dt),
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                  ),
                ),
                Image.asset(
                  "${AssetPaths.weatherPath}/${item.weather![0].icon}.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  "${item.temp!.max}°/${item.temp!.min}°",
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final dayName = DateFormat('EEE').format(time);
    return dayName;
  }
}
