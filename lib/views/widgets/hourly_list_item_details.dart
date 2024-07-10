import 'package:flutter/material.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';
import 'package:modern_weather_getx/utils/const_function.dart';

class HourlyListItemDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  final Color textColor;

  const HourlyListItemDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            "${AssetPaths.weatherPath}/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: "${ConstFunction.getFormatTime(timeStamp, "j")}\n",
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "$temp°C",
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
