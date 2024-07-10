import 'package:flutter/material.dart';
import 'package:modern_weather_getx/utils/app_color.dart';

class CurrentWeatherMoreDetailsItem extends StatelessWidget {
  const CurrentWeatherMoreDetailsItem(
      {super.key, required this.assetPath, required this.textValue,});

  final String assetPath;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColor.cardColor.withAlpha(70),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(assetPath),
        ),
        const SizedBox(height: 8),
        Text(
          textValue,
          style: const TextStyle(
            fontSize: 14,
            color: AppColor.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
