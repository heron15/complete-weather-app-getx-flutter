import 'package:flutter/material.dart';
import 'package:modern_weather_getx/data/model/weather_data_current.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ComfortLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const ComfortLevel({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.white,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
          width: double.maxFinite,
          height: 1,
          color: AppColor.dividerLine.withAlpha(60),
        ),
        SizedBox(
          height: 180,
          child: Center(
            child: SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: weatherDataCurrent.current.humidity!.toDouble(),
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  handlerSize: 0,
                  trackWidth: 12,
                  progressBarWidth: 12,
                ),
                infoProperties: InfoProperties(
                  mainLabelStyle: TextStyle(
                    color: AppColor.dividerLine.withAlpha(220),
                    fontSize: 24,
                  ),
                  bottomLabelText: "Humidity",
                  bottomLabelStyle: TextStyle(
                    letterSpacing: 0.1,
                    fontSize: 14,
                    height: 1.5,
                    color: AppColor.dividerLine.withAlpha(220),
                  ),
                ),
                animationEnabled: true,
                size: 140,
                customColors: CustomSliderColors(
                  hideShadow: true,
                  trackColor: AppColor.dividerLine.withAlpha(220),
                  progressBarColors: [
                    AppColor.firstGradientColor,
                    AppColor.secondGradientColor,
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
