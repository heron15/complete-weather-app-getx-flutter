import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/utils/asset_paths.dart';
import 'package:modern_weather_getx/views/widgets/app_background_widget.dart';
import 'package:modern_weather_getx/views/widgets/center_circular_progress.dart';
import 'package:modern_weather_getx/views/widgets/comfort_level.dart';
import 'package:modern_weather_getx/views/widgets/current_weather_widget.dart';
import 'package:modern_weather_getx/views/widgets/daily_data_widget.dart';
import 'package:modern_weather_getx/views/widgets/header_widget.dart';
import 'package:modern_weather_getx/views/widgets/hourly_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBg,
      body: Obx(
        () => globalController.connectionStatus.value == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetPaths.noInternetIcon,
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Oops, No Internet Connection!",
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        textAlign: TextAlign.center,
                        "Make Sure wifi or cellular data is turned on and then try again.",
                        style: TextStyle(
                          color: AppColor.dividerLine.withAlpha(200),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Icon(
                        Icons.refresh,
                        color: AppColor.dividerLine.withAlpha(190),
                        size: 35,
                      ),
                    ],
                  ),
                ),
              )
            : globalController.checkLoading().isTrue
                ? const CenterCircularProgress()
                : AppBackgroundWidget(
                    iconName: globalController
                        .getWeatherData()
                        .getCurrentWeather()
                        .current
                        .weather![0]
                        .icon!,
                    child: RefreshIndicator(
                      backgroundColor: Colors.transparent,
                      color: AppColor.appColor,
                      onRefresh: () async {
                        await globalController.refreshWeatherData();
                      },
                      child: globalController.checkRefreshing().isTrue
                          ? const CenterCircularProgress()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                children: [
                                  const SizedBox(height: 10),
                                  HeaderWidget(
                                    globalController: globalController,
                                  ),
                                  CurrentWeatherWidget(
                                    weatherDataCurrent:
                                        globalController.getWeatherData().getCurrentWeather(),
                                  ),
                                  HourlyWeatherWidget(
                                    weatherDataHourly:
                                        globalController.getWeatherData().getHourlyWeather(),
                                  ),
                                  DailyDataWidget(
                                    weatherDataDaily:
                                        globalController.getWeatherData().getDailyWeather(),
                                  ),
                                  ComfortLevel(
                                    weatherDataCurrent:
                                        globalController.getWeatherData().getCurrentWeather(),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
      ),
    );
  }
}
