import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/data/model/weather_data_current.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';
import 'package:modern_weather_getx/utils/const_function.dart';
import 'package:modern_weather_getx/views/widgets/details_item_widget.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    super.key,
    required this.weatherDataCurrent,
  });

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController = Get.put(GlobalController());
    return Column(
      children: [
        const SizedBox(height: 15),
        temperatureAreaWidget(),
        const SizedBox(height: 10),
        feelLikeAndDescWidget(),
        const SizedBox(height: 15),
        Obx(() => currentWeatherMoreDetailsWidget(globalController)),
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weatherDataCurrent.current.temp!.toInt()}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                  fontSize: 68,
                ),
              ),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: const Text(
                    "°",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                      fontSize: 30,
                      letterSpacing: 7,
                    ),
                  ),
                ),
              ),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: const Text(
                    "C",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 2,
          height: 60,
          color: AppColor.dividerLine.withAlpha(60),
        ),
        Image.asset(
          '${AssetPaths.weatherPath}/${weatherDataCurrent.current.weather![0].icon}.png',
          height: 80,
          width: 80,
        ),
      ],
    );
  }

  Widget feelLikeAndDescWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Feel Like ${weatherDataCurrent.current.feelsLike}°",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withAlpha(150),
            ),
          ),
          Text(
            "It's ${weatherDataCurrent.current.weather![0].description!}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.white.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentWeatherMoreDetailsWidget(GlobalController globalController) {
    //for sunrise & sunset time
    String timeOfSunrise = ConstFunction.getFormatTime(weatherDataCurrent.current.sunrise!, "jm");
    String timeOfSunset = ConstFunction.getFormatTime(weatherDataCurrent.current.sunset!, "jm");

    //for uv index
    String uvIndexSubValue;
    double uvIndexValue = weatherDataCurrent.current.uvIndex!;

    if (uvIndexValue >= 1 && uvIndexValue <3) {
      uvIndexSubValue = "L";
    } else if (uvIndexValue >= 3 && uvIndexValue <6) {
      uvIndexSubValue = "M";
    } else if (uvIndexValue >= 6 && uvIndexValue <8) {
      uvIndexSubValue = "H";
    } else if (uvIndexValue >= 8 && uvIndexValue <= 10) {
      uvIndexSubValue = "VH";
    } else if (uvIndexValue > 10) {
      uvIndexSubValue = "Ex";
    } else {
      uvIndexSubValue = "VL";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Details",
                style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: globalController.toggleThirdRowVisibility,
                icon: Icon(
                  globalController.getIsThirdRowVisible().value
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: AppColor.white,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: double.maxFinite,
            height: 1,
            color: AppColor.dividerLine.withAlpha(60),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailsItemWidget(
                icon: AssetPaths.sunrise,
                titleText: "Sunrise",
                valueText: timeOfSunrise.substring(0, timeOfSunrise.length - 3),
                valueSubText: timeOfSunrise.substring(timeOfSunrise.length - 2),
              ),
              DetailsItemWidget(
                icon: AssetPaths.sunset,
                titleText: "Sunset",
                valueText: timeOfSunset.substring(0, timeOfSunset.length - 3),
                valueSubText: timeOfSunset.substring(timeOfSunset.length - 2),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailsItemWidget(
                icon: AssetPaths.windSpeed,
                titleText: "Wind Speed",
                valueText: weatherDataCurrent.current.windSpeed.toString(),
                valueSubText: "km/h",
              ),
              DetailsItemWidget(
                icon: AssetPaths.humidity,
                titleText: "Humidity",
                valueText: weatherDataCurrent.current.humidity.toString(),
                valueSubText: "%",
              ),
            ],
          ),
          Visibility(
            visible: globalController.getIsThirdRowVisible().value,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DetailsItemWidget(
                      icon: AssetPaths.clouds,
                      titleText: "Clouds",
                      valueText: weatherDataCurrent.current.clouds.toString(),
                      valueSubText: "%",
                    ),
                    DetailsItemWidget(
                      icon: AssetPaths.uvIndex,
                      titleText: "UV Index",
                      valueText: weatherDataCurrent.current.uvIndex.toString(),
                      valueSubText: uvIndexSubValue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
