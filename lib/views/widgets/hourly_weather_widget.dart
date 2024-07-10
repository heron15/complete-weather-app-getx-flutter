import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/data/model/weather_data_hourly.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/views/widgets/hourly_list_item_details.dart';

class HourlyWeatherWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyWeatherWidget({super.key, required this.weatherDataHourly});

  @override
  State<HourlyWeatherWidget> createState() => _HourlyWeatherWidgetState();
}

class _HourlyWeatherWidgetState extends State<HourlyWeatherWidget> {
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: const Text(
            "Today",
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
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 125,
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 12
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 110,
                margin: const EdgeInsets.only(left: 15, right: 5),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.dividerLine.withAlpha(70),
                    ),
                  ],
                  gradient: cardIndex.value == index
                      ? const LinearGradient(
                          colors: [
                            AppColor.firstGradientColor,
                            AppColor.secondGradientColor,
                          ],
                        )
                      : null,
                ),
                child: HourlyListItemDetails(
                  temp: widget.weatherDataHourly.hourly[index].temp!,
                  timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                  weatherIcon: widget.weatherDataHourly.hourly[index].weather![0].icon!,
                  textColor: cardIndex.value == index
                      ? AppColor.white
                      : AppColor.dividerLine.withAlpha(220),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
