import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';
import 'package:modern_weather_getx/utils/app_color.dart';
import 'package:modern_weather_getx/views/widgets/app_background_widget.dart';
import 'package:modern_weather_getx/views/widgets/center_circular_progress.dart';
import 'package:modern_weather_getx/views/widgets/comfort_level.dart';
import 'package:modern_weather_getx/views/widgets/current_weather_widget.dart';
import 'package:modern_weather_getx/views/widgets/daily_data_widget.dart';
import 'package:modern_weather_getx/views/widgets/header_widget.dart';
import 'package:modern_weather_getx/views/widgets/hourly_weather_widget.dart';
import 'package:modern_weather_getx/views/widgets/no_internet_connection_widget.dart';

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
            ? const NoInternetConnectionWidget()
            : globalController.checkLoading().isTrue
                ? const CenterCircularProgress()
                : homeAppBackgroundWidget(),
      ),
    );
  }

  AppBackgroundWidget homeAppBackgroundWidget() {
    return AppBackgroundWidget(
      iconName: globalController.getWeatherData().getCurrentWeather().current.weather![0].icon!,
      child: RefreshIndicator(
        backgroundColor: Colors.transparent,
        color: AppColor.appColor,
        onRefresh: () async {
          await globalController.refreshWeatherData();
        },
        child: globalController.checkRefreshing().isTrue
            ? const CenterCircularProgress()
            : homePageMainPart(),
      ),
    );
  }

  Widget homePageMainPart() {
    return Padding(
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
            weatherDataCurrent: globalController.getWeatherData().getCurrentWeather(),
          ),
          HourlyWeatherWidget(
            weatherDataHourly: globalController.getWeatherData().getHourlyWeather(),
          ),
          DailyDataWidget(
            weatherDataDaily: globalController.getWeatherData().getDailyWeather(),
          ),
          ComfortLevel(
            weatherDataCurrent: globalController.getWeatherData().getCurrentWeather(),
          ),
        ],
      ),
    );
  }
}
